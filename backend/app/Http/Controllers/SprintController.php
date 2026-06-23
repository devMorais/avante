<?php

namespace App\Http\Controllers;

use App\Models\Sprint;
use App\Models\Task;
use Illuminate\Http\Request;

class SprintController extends Controller
{
    public function index(Request $request)
    {
        $query = Sprint::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('start_date')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'   => 'required|exists:boards,id',
            'name'       => 'required|string|max:255',
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date|after_or_equal:start_date',
        ]);

        $sprint = Sprint::create($validated);

        return response()->json($sprint, 201);
    }

    public function update(Request $request, string $id)
    {
        $sprint = Sprint::findOrFail($id);

        $validated = $request->validate([
            'name'       => 'sometimes|string|max:255',
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date|after_or_equal:start_date',
        ]);

        $sprint->update($validated);

        return response()->json($sprint);
    }

    public function destroy(string $id)
    {
        $sprint = Sprint::findOrFail($id);
        $sprint->delete();

        return response()->json(['message' => 'Sprint removido com sucesso']);
    }

    /**
     * Finaliza a sprint:
     * - Marca finished_at = now()
     * - Tarefas sem status "concluído" são transbordadas para a próxima sprint
     *   (a sprint imediatamente posterior por start_date, se existir)
     *
     * O frontend envia o ID do status considerado "concluído" via body:
     *   { "concluded_status_id": 5 }
     * Se não enviar, usa o nome do status como fallback (busca por nome "Concluído" ou "Concluido").
     */
    public function finish(Request $request, string $id)
    {
        $sprint = Sprint::findOrFail($id);

        if ($sprint->isFinished()) {
            return response()->json(['message' => 'Sprint já finalizada.'], 422);
        }

        // Descobrir o status "concluído"
        $concludedStatusId = $request->input('concluded_status_id');

        if (!$concludedStatusId) {
            // Fallback: busca pelo nome
            $concludedStatus = \App\Models\Status::where('board_id', $sprint->board_id)
                ->whereRaw("LOWER(name) IN ('concluído', 'concluido', 'done', 'finalizado')")
                ->first();
            $concludedStatusId = $concludedStatus?->id;
        }

        // Próxima sprint do mesmo quadro (por start_date)
        $nextSprint = Sprint::where('board_id', $sprint->board_id)
            ->where('id', '!=', $sprint->id)
            ->whereNull('finished_at')
            ->where(function ($q) use ($sprint) {
                if ($sprint->end_date) {
                    $q->where('start_date', '>', $sprint->end_date);
                } else {
                    $q->where('id', '>', $sprint->id);
                }
            })
            ->orderBy('start_date')
            ->first();

        // Tarefas não concluídas desta sprint
        $incompleteTasks = Task::where('sprint_id', $sprint->id)
            ->when($concludedStatusId, function ($q) use ($concludedStatusId) {
                $q->where(function ($inner) use ($concludedStatusId) {
                    $inner->where('status_id', '!=', $concludedStatusId)
                        ->orWhereNull('status_id');
                });
            })
            ->when(!$concludedStatusId, function ($q) {
                // sem status concluído identificado: transborda todas sem status
                $q->whereNull('status_id');
            })
            ->get();

        // Transbordar
        $overflowCount = 0;
        if ($nextSprint && $incompleteTasks->isNotEmpty()) {
            Task::whereIn('id', $incompleteTasks->pluck('id'))
                ->update(['sprint_id' => $nextSprint->id]);
            $overflowCount = $incompleteTasks->count();
        }

        // Finalizar sprint
        $sprint->update(['finished_at' => now()]);

        return response()->json([
            'message'        => 'Sprint finalizada com sucesso.',
            'overflow_count' => $overflowCount,
            'next_sprint_id' => $nextSprint?->id,
            'next_sprint'    => $nextSprint?->name,
            'sprint'         => $sprint->fresh(),
        ]);
    }
}
