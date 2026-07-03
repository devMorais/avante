<?php

namespace App\Http\Controllers;

use App\Models\MarketingIdea;
use Illuminate\Http\Request;

class MarketingIdeaController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketingIdea::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderByDesc('votes')->orderByDesc('created_at')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'    => 'required|exists:boards,id',
            'title'       => 'required|string|max:255',
            'description' => 'nullable|string',
            'tags'        => 'nullable|string|max:255',
        ]);

        $idea = MarketingIdea::create($validated);

        return response()->json($idea, 201);
    }

    public function update(Request $request, string $id)
    {
        $idea = MarketingIdea::findOrFail($id);

        $validated = $request->validate([
            'title'       => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'tags'        => 'nullable|string|max:255',
            'votes'       => 'nullable|integer',
        ]);

        $idea->update($validated);

        return response()->json($idea);
    }

    public function upvote(string $id)
    {
        $idea = MarketingIdea::findOrFail($id);
        $idea->increment('votes');

        return response()->json($idea);
    }

    public function destroy(string $id)
    {
        MarketingIdea::findOrFail($id)->delete();

        return response()->json(['message' => 'Ideia removida com sucesso']);
    }
}
