<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    // Relacionamentos padrão reutilizados em todos os métodos
    private array $with = [
        'sprint',
        'status',
        'assignees:id,name,email,avatar_url',
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
        if ($request->filled('search')) {
            $query->where('description', 'like', '%' . $request->search . '%');
        }

        $query->orderBy('created_at', 'desc');

        $perPage = $request->get('per_page', 25);
        $tasks = $query->paginate($perPage);

        return response()->json($tasks);
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
        ]);

        $task = Task::create($validated);

        if (!empty($validated['assigned_to'])) {
            $task->assignees()->sync([$validated['assigned_to']]);
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
            'description'    => 'sometimes|required|string',
            'priority'       => 'nullable|string',
            'epic'           => 'nullable|string',
        ]);

        $task->update(collect($validated)->except('assignee_ids')->toArray());

        if ($request->has('assignee_ids')) {
            $task->assignees()->sync($validated['assignee_ids'] ?? []);
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
}
