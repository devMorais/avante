<?php

namespace App\Http\Controllers;

use App\Models\MarketingCampaign;
use Illuminate\Http\Request;

class MarketingCampaignController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketingCampaign::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderByDesc('start_date')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'   => 'required|exists:boards,id',
            'name'       => 'required|string|max:255',
            'channels'   => 'nullable|string|max:255',
            'budget'     => 'nullable|numeric',
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date',
            'goal'       => 'nullable|string|max:255',
            'status'     => 'nullable|in:planejada,ativa,concluida',
        ]);

        $campaign = MarketingCampaign::create($validated);

        return response()->json($campaign, 201);
    }

    public function update(Request $request, string $id)
    {
        $campaign = MarketingCampaign::findOrFail($id);

        $validated = $request->validate([
            'name'       => 'sometimes|required|string|max:255',
            'channels'   => 'nullable|string|max:255',
            'budget'     => 'nullable|numeric',
            'start_date' => 'nullable|date',
            'end_date'   => 'nullable|date',
            'goal'       => 'nullable|string|max:255',
            'status'     => 'nullable|in:planejada,ativa,concluida',
        ]);

        $campaign->update($validated);

        return response()->json($campaign);
    }

    public function destroy(string $id)
    {
        MarketingCampaign::findOrFail($id)->delete();

        return response()->json(['message' => 'Campanha removida com sucesso']);
    }
}
