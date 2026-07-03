<?php

namespace App\Http\Controllers;

use App\Models\MarketingLead;
use Illuminate\Http\Request;

class MarketingLeadController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketingLead::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderByDesc('created_at')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'name'     => 'required|string|max:255',
            'contact'  => 'nullable|string|max:255',
            'stage'    => 'nullable|in:novo,contato,proposta,ganho,perdido',
            'value'    => 'nullable|numeric',
            'notes'    => 'nullable|string',
        ]);

        $lead = MarketingLead::create($validated);

        return response()->json($lead, 201);
    }

    public function update(Request $request, string $id)
    {
        $lead = MarketingLead::findOrFail($id);

        $validated = $request->validate([
            'name'    => 'sometimes|required|string|max:255',
            'contact' => 'nullable|string|max:255',
            'stage'   => 'nullable|in:novo,contato,proposta,ganho,perdido',
            'value'   => 'nullable|numeric',
            'notes'   => 'nullable|string',
        ]);

        $lead->update($validated);

        return response()->json($lead);
    }

    public function destroy(string $id)
    {
        MarketingLead::findOrFail($id)->delete();

        return response()->json(['message' => 'Lead removido com sucesso']);
    }
}
