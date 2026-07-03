<?php

namespace App\Http\Controllers;

use App\Models\MarketingMetric;
use Illuminate\Http\Request;

class MarketingMetricController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketingMetric::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderByDesc('period_date')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'    => 'required|exists:boards,id',
            'channel'     => 'required|string|max:50',
            'period_date' => 'required|date',
            'reach'       => 'nullable|integer|min:0',
            'engagement'  => 'nullable|integer|min:0',
            'conversions' => 'nullable|integer|min:0',
        ]);

        $metric = MarketingMetric::create($validated);

        return response()->json($metric, 201);
    }

    public function destroy(string $id)
    {
        MarketingMetric::findOrFail($id)->delete();

        return response()->json(['message' => 'Métrica removida com sucesso']);
    }
}
