<?php

namespace App\Http\Controllers;

use App\Models\Priority;
use App\Models\Task;
use Illuminate\Http\Request;

class PriorityController extends Controller
{
    public function index(Request $request)
    {
        $query = Priority::query();

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
            $validated['order'] = Priority::where('board_id', $validated['board_id'])
                ->where('area', $validated['area'])
                ->max('order') + 1;
        }

        $priority = Priority::create($validated);

        return response()->json($priority, 201);
    }

    public function update(Request $request, string $id)
    {
        $priority = Priority::findOrFail($id);
        $oldName = $priority->name;

        $validated = $request->validate([
            'name'  => 'sometimes|string|max:255',
            'color' => 'nullable|string|max:7',
            'order' => 'nullable|integer',
        ]);

        $priority->update($validated);

        // Cascata: renomeia o valor nas tarefas que usam essa prioridade
        // (filtra por area também — nomes podem se repetir entre áreas)
        if (isset($validated['name']) && $validated['name'] !== $oldName) {
            Task::where('board_id', $priority->board_id)
                ->where('area', $priority->area)
                ->where('priority', $oldName)
                ->update(['priority' => $validated['name']]);
        }

        return response()->json($priority);
    }

    public function destroy(string $id)
    {
        $priority = Priority::findOrFail($id);
        $priority->delete();

        return response()->json(['message' => 'Prioridade removida com sucesso']);
    }

    /**
     * Reordena prioridades em massa via drag-and-drop.
     * Body: { items: [{ id, order }] }
     */
    public function reorder(Request $request)
    {
        $request->validate([
            'items'         => 'required|array',
            'items.*.id'    => 'required|exists:priorities,id',
            'items.*.order' => 'required|integer',
        ]);

        foreach ($request->items as $item) {
            Priority::where('id', $item['id'])->update(['order' => $item['order']]);
        }

        return response()->json(['message' => 'Prioridades reordenadas']);
    }
}
