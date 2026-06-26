<?php

namespace App\Http\Controllers;

use App\Models\Tag;
use Illuminate\Http\Request;

class TagController extends Controller
{
    public function index(Request $request)
    {
        $query = Tag::query();

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('name')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id' => 'required|exists:boards,id',
            'name'     => 'required|string|max:50',
            'color'    => 'nullable|string|max:7',
        ]);

        $tag = Tag::create($validated);

        return response()->json($tag, 201);
    }

    public function update(Request $request, string $id)
    {
        $tag = Tag::findOrFail($id);

        $validated = $request->validate([
            'name'  => 'sometimes|string|max:50',
            'color' => 'nullable|string|max:7',
        ]);

        $tag->update($validated);

        return response()->json($tag);
    }

    public function destroy(string $id)
    {
        $tag = Tag::findOrFail($id);
        $tag->delete();

        return response()->json(['message' => 'Tag removida com sucesso']);
    }
}
