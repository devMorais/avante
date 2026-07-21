<?php

namespace App\Http\Controllers;

use App\Models\Status;
use App\Models\Task;
use App\Services\WhatsAppGateway;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    private array $with = [
        'sprint',
        'status',
        'assignees:id,name,email,avatar_url',
        'tags:id,name,color',
    ];

    public function index(Request $request)
    {
        $query = Task::query()->with($this->with);

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }
        $query->where('area', $request->input('area', 'programming'));
        if ($request->filled('status_ids')) {
            $query->whereIn('status_id', $request->status_ids);
        }
        if ($request->filled('priorities')) {
            $query->whereIn('priority', $request->priorities);
        }
        if ($request->filled('assignee_ids')) {
            $query->whereHas('assignees', function ($q) use ($request) {
                $q->whereIn('users.id', $request->assignee_ids);
            });
        }
        if ($request->filled('tag_ids')) {
            $query->whereHas('tags', function ($q) use ($request) {
                $q->whereIn('tags.id', $request->tag_ids);
            });
        }
        if ($request->filled('search')) {
            $term = '%' . $request->search . '%';
            $query->where(function ($q) use ($term) {
                $q->where('titulo', 'like', $term)
                    ->orWhere('description', 'like', $term);
            });
        }

        $query->orderBy('sort_order')->orderBy('created_at', 'desc');

        return response()->json($query->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'    => 'required|exists:boards,id',
            'area'        => 'nullable|in:programming,marketing',
            'sprint_id'   => 'nullable|exists:sprints,id',
            'status_id'   => 'nullable|exists:statuses,id',
            'assigned_to' => 'nullable|exists:users,id',
            'titulo'      => 'required|string|max:150',
            'description' => 'required|string',
            'priority'    => 'nullable|string',
            'epic'        => 'nullable|string',
            'release'     => 'nullable|string',
            'type'        => 'nullable|string',
            'sort_order'  => 'nullable|integer',
            'tag_ids'     => 'nullable|array',
            'tag_ids.*'   => 'exists:tags,id',
        ]);

        $validated['area'] ??= 'programming';

        if (!isset($validated['sort_order'])) {
            $validated['sort_order'] = Task::where('board_id', $validated['board_id'])
                ->when(isset($validated['sprint_id']), fn($q) => $q->where('sprint_id', $validated['sprint_id']))
                ->max('sort_order') + 1;
        }

        $task = Task::create(collect($validated)->except('tag_ids')->toArray());

        if (!empty($validated['assigned_to'])) {
            $task->assignees()->sync([$validated['assigned_to']]);
        }

        if ($request->has('tag_ids')) {
            $task->tags()->sync($validated['tag_ids'] ?? []);
        }

        $this->syncCompletedAt($task);
        $task->load($this->with);

        return response()->json($task, 201);
    }

    public function show(string $id)
    {
        $task = Task::with($this->with)->findOrFail($id);
        return response()->json($task);
    }

    public function update(Request $request, string $id)
    {
        $task = Task::findOrFail($id);

        $validated = $request->validate([
            'sprint_id'      => 'nullable|exists:sprints,id',
            'status_id'      => 'nullable|exists:statuses,id',
            'assigned_to'    => 'nullable|exists:users,id',
            'assignee_ids'   => 'nullable|array',
            'assignee_ids.*' => 'exists:users,id',
            'tag_ids'        => 'nullable|array',
            'tag_ids.*'      => 'exists:tags,id',
            'titulo'         => 'sometimes|required|string|max:150',
            'description'    => 'sometimes|required|string',
            'priority'       => 'nullable|string',
            'epic'           => 'nullable|string',
            'release'        => 'nullable|string',
            'type'           => 'nullable|string',
            'notes'          => 'nullable|string',
            'sort_order'     => 'nullable|integer',
            'scheduled_at'   => 'nullable|date',
        ]);

        $oldStatusId = $task->status_id;
        $task->update(collect($validated)->except(['assignee_ids', 'tag_ids'])->toArray());

        if ($request->has('assignee_ids')) {
            $task->assignees()->sync($validated['assignee_ids'] ?? []);
        }

        if ($request->has('tag_ids')) {
            $task->tags()->sync($validated['tag_ids'] ?? []);
        }

        if (array_key_exists('status_id', $validated)) {
            $this->syncCompletedAt($task);
            if ($task->status_id != $oldStatusId) {
                $this->notifyWhatsAppStatusChange($task);
            }
        }
        $task->load($this->with);

        return response()->json($task);
    }

    public function destroy(string $id)
    {
        $task = Task::findOrFail($id);
        $task->delete();

        return response()->json(['message' => 'Tarefa removida com sucesso']);
    }

    /**
     * Reordena tarefas em massa: body = [{ id, sort_order }]
     */
    public function reorder(Request $request)
    {
        $request->validate([
            'items'             => 'required|array',
            'items.*.id'        => 'required|exists:tasks,id',
            'items.*.sort_order'=> 'required|integer',
        ]);

        foreach ($request->items as $item) {
            Task::where('id', $item['id'])->update(['sort_order' => $item['sort_order']]);
        }

        return response()->json(['message' => 'Tarefas reordenadas']);
    }

    /**
     * Atualiza vários campos de várias tarefas em uma única requisição.
     * status_id/priority/type/sprint_id: substituem o valor (aceitam null para limpar).
     * add_tag_id/add_assignee_id: adicionam sem remover os já existentes em cada tarefa.
     */
    public function bulkUpdate(Request $request)
    {
        $validated = $request->validate([
            'task_ids'        => 'required|array|min:1',
            'task_ids.*'      => 'exists:tasks,id',
            'status_id'       => 'nullable|exists:statuses,id',
            'priority'        => 'nullable|string',
            'type'            => 'nullable|string',
            'sprint_id'       => 'nullable|exists:sprints,id',
            'scheduled_at'    => 'nullable|date',
            'add_tag_id'      => 'nullable|exists:tags,id',
            'add_assignee_id' => 'nullable|exists:users,id',
        ]);

        $ids = $validated['task_ids'];

        $fields = collect($validated)->only(['status_id', 'priority', 'type', 'sprint_id', 'scheduled_at'])->toArray();
        if (!empty($fields)) {
            Task::whereIn('id', $ids)->update($fields);
        }

        if (array_key_exists('status_id', $fields)) {
            foreach (Task::whereIn('id', $ids)->get() as $task) {
                $this->syncCompletedAt($task);
            }
        }

        if (array_key_exists('add_tag_id', $validated)) {
            foreach (Task::whereIn('id', $ids)->get() as $task) {
                $task->tags()->syncWithoutDetaching([$validated['add_tag_id']]);
            }
        }

        if (array_key_exists('add_assignee_id', $validated)) {
            foreach (Task::whereIn('id', $ids)->get() as $task) {
                $task->assignees()->syncWithoutDetaching([$validated['add_assignee_id']]);
            }
        }

        return response()->json(Task::with($this->with)->whereIn('id', $ids)->get());
    }

    /**
     * Preenche/limpa tasks.completed_at conforme o status atual da tarefa
     * ser ou não o status "concluído" do board — usado para velocidade/cycle
     * time no Analytics.
     */
    private function syncCompletedAt(Task $task): void
    {
        $concludedId = Status::concludedIdFor($task->board_id, $task->area);
        $isConcluded = $concludedId && (int) $task->status_id === (int) $concludedId;

        if ($isConcluded && !$task->completed_at) {
            $task->update(['completed_at' => now()]);
        } elseif (!$isConcluded && $task->completed_at) {
            $task->update(['completed_at' => null]);
        }
    }

    /**
     * Avisa por WhatsApp (se configurado e o usuário optou por receber)
     * quando a tarefa entra num status de "em andamento".
     */
    private function notifyWhatsAppStatusChange(Task $task): void
    {
        $statusName = strtolower($task->status?->name ?? '');
        if (!str_contains($statusName, 'andamento')) {
            return;
        }

        $gateway = app(WhatsAppGateway::class);
        foreach ($task->assignees as $assignee) {
            if ($assignee->whatsapp_opt_in && $assignee->whatsapp_number) {
                $gateway->send(
                    $assignee->whatsapp_number,
                    "Sua demanda \"{$task->description}\" está em andamento. Continue assim — está tudo sendo observado! 👀"
                );
            }
        }
    }
}
