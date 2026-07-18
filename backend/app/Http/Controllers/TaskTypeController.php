<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Models\TaskType;
use Illuminate\Http\Request;

class TaskTypeController extends Controller
{
    public function index(Request $request)
    {
        $query = TaskType::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }
        $query->where('area', $request->input('area', 'programming'));

        return response()->json($query->orderBy('order')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'area'     => 'nullable|in:programming,marketing',
            'name'     => 'required|string|max:255',
            'color'    => 'nullable|string|max:7',
            'order'    => 'nullable|integer',
        ]);

        $validated['area'] ??= 'programming';

        if (!isset($validated['order'])) {
            $validated['order'] = TaskType::where('board_id', $validated['board_id'])
                ->where('area', $validated['area'])
                ->max('order') + 1;
        }

        $type = TaskType::create($validated);

        return response()->json($type, 201);
    }

    public function update(Request $request, string $id)
    {
        $type = TaskType::findOrFail($id);
        $oldName = $type->name;

        $validated = $request->validate([
            'name'  => 'sometimes|string|max:255',
            'color' => 'nullable|string|max:7',
            'order' => 'nullable|integer',
        ]);

        $type->update($validated);

        // Cascata: renomeia o valor nas tarefas que usam esse tipo
        // (filtra por area também — nomes podem se repetir entre áreas)
        if (isset($validated['name']) && $validated['name'] !== $oldName) {
            Task::where('board_id', $type->board_id)
                ->where('area', $type->area)
                ->where('type', $oldName)
                ->update(['type' => $validated['name']]);
        }

        return response()->json($type);
    }

    public function destroy(string $id)
    {
        $type = TaskType::findOrFail($id);
        $type->delete();

        return response()->json(['message' => 'Tipo removido com sucesso']);
    }

    public function reorder(Request $request)
    {
        $request->validate([
            'items'         => 'required|array',
            'items.*.id'    => 'required|exists:task_types,id',
            'items.*.order' => 'required|integer',
        ]);

        foreach ($request->items as $item) {
            TaskType::where('id', $item['id'])->update(['order' => $item['order']]);
        }

        return response()->json(['message' => 'Tipos reordenados']);
    }
}
