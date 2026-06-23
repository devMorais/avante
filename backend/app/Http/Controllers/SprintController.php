<?php

namespace App\Http\Controllers;

use App\Models\Sprint;
use Illuminate\Http\Request;

class SprintController extends Controller
{
    /**
     * Lista os sprints de um quadro específico.
     */
    public function index(Request $request)
    {
        $query = Sprint::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('start_date')->get());
    }

    /**
     * Cria um novo sprint.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'name' => 'required|string|max:255',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $sprint = Sprint::create($validated);

        return response()->json($sprint, 201);
    }

    /**
     * Atualiza um sprint existente.
     */
    public function update(Request $request, string $id)
    {
        $sprint = Sprint::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $sprint->update($validated);

        return response()->json($sprint);
    }

    /**
     * Remove um sprint.
     */
    public function destroy(string $id)
    {
        $sprint = Sprint::findOrFail($id);
        $sprint->delete();

        return response()->json(['message' => 'Sprint removido com sucesso']);
    }
}
