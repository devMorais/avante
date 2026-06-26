<?php

namespace App\Http\Controllers;

use App\Models\Status;
use Illuminate\Http\Request;

class StatusController extends Controller
{
    public function index(Request $request)
    {
        $query = Status::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('order')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'name'     => 'required|string|max:255',
            'color'    => 'nullable|string|max:7',
            'order'    => 'nullable|integer',
        ]);

        if (!isset($validated['order'])) {
            $validated['order'] = Status::where('board_id', $validated['board_id'])->max('order') + 1;
        }

        $status = Status::create($validated);

        return response()->json($status, 201);
    }

    public function update(Request $request, string $id)
    {
        $status = Status::findOrFail($id);

        $validated = $request->validate([
            'name'  => 'sometimes|string|max:255',
            'color' => 'nullable|string|max:7',
            'order' => 'nullable|integer',
        ]);

        $status->update($validated);

        return response()->json($status);
    }

    public function destroy(string $id)
    {
        $status = Status::findOrFail($id);
        $status->delete();

        return response()->json(['message' => 'Status removido com sucesso']);
    }

    /**
     * Reordena status em massa via drag-and-drop.
     * Body: { items: [{ id, order }] }
     */
    public function reorder(Request $request)
    {
        $request->validate([
            'items'          => 'required|array',
            'items.*.id'     => 'required|exists:statuses,id',
            'items.*.order'  => 'required|integer',
        ]);

        foreach ($request->items as $item) {
            Status::where('id', $item['id'])->update(['order' => $item['order']]);
        }

        return response()->json(['message' => 'Status reordenados']);
    }
}
