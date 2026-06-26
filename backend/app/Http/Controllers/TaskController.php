<?php

namespace App\Http\Controllers;

use App\Models\Task;
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
            $query->where('description', 'like', '%' . $request->search . '%');
        }

        $query->orderBy('sort_order')->orderBy('created_at', 'desc');

        return response()->json($query->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'    => 'required|exists:boards,id',
            'sprint_id'   => 'nullable|exists:sprints,id',
            'status_id'   => 'nullable|exists:statuses,id',
            'assigned_to' => 'nullable|exists:users,id',
            'description' => 'required|string',
            'priority'    => 'nullable|string',
            'epic'        => 'nullable|string',
            'release'     => 'nullable|string',
            'sort_order'  => 'nullable|integer',
            'tag_ids'     => 'nullable|array',
            'tag_ids.*'   => 'exists:tags,id',
        ]);

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
            'description'    => 'sometimes|required|string',
            'priority'       => 'nullable|string',
            'epic'           => 'nullable|string',
            'release'        => 'nullable|string',
            'notes'          => 'nullable|string',
            'sort_order'     => 'nullable|integer',
        ]);

        $task->update(collect($validated)->except(['assignee_ids', 'tag_ids'])->toArray());

        if ($request->has('assignee_ids')) {
            $task->assignees()->sync($validated['assignee_ids'] ?? []);
        }

        if ($request->has('tag_ids')) {
            $task->tags()->sync($validated['tag_ids'] ?? []);
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
}
