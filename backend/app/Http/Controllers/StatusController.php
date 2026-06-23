<?php

namespace App\Http\Controllers;

use App\Models\Status;
use Illuminate\Http\Request;

class StatusController extends Controller
{
    /**
     * Lista os status de um quadro específico, ordenados.
     */
    public function index(Request $request)
    {
        $query = Status::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('order')->get());
    }

    /**
     * Cria um novo status.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'name' => 'required|string|max:255',
            'color' => 'nullable|string|max:7',
            'order' => 'nullable|integer',
        ]);

        // Se não vier order, coloca no final da lista
        if (!isset($validated['order'])) {
            $validated['order'] = Status::where('board_id', $validated['board_id'])->max('order') + 1;
        }

        $status = Status::create($validated);

        return response()->json($status, 201);
    }

    /**
     * Atualiza um status existente (nome, cor ou ordem).
     */
    public function update(Request $request, string $id)
    {
        $status = Status::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'color' => 'nullable|string|max:7',
            'order' => 'nullable|integer',
        ]);

        $status->update($validated);

        return response()->json($status);
    }

    /**
     * Remove um status. As tarefas que usavam esse status ficam com
     * status_id = null (definido na migration com onDelete('set null')).
     */
    public function destroy(string $id)
    {
        $status = Status::findOrFail($id);
        $status->delete();

        return response()->json(['message' => 'Status removido com sucesso']);
    }
}
