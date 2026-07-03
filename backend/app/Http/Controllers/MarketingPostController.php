<?php

namespace App\Http\Controllers;

use App\Models\MarketingPost;
use Illuminate\Http\Request;

class MarketingPostController extends Controller
{
    public function index(Request $request)
    {
        $query = MarketingPost::query()->with('user:id,name,avatar_url');

        if ($request->has('board_id')) {
            $query->where('board_id', $request->board_id);
        }

        return response()->json($query->orderBy('scheduled_at')->orderByDesc('created_at')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'board_id'     => 'required|exists:boards,id',
            'title'        => 'required|string|max:255',
            'caption'      => 'nullable|string',
            'channel'      => 'nullable|string|max:50',
            'scheduled_at' => 'nullable|date',
            'status'       => 'nullable|in:idea,scheduled,published',
        ]);

        $validated['user_id'] = $request->user()->id;

        if ($request->hasFile('image')) {
            $validated['image_path'] = $request->file('image')->store('marketing-posts', 'public');
        }

        $post = MarketingPost::create($validated);

        return response()->json($post->load('user:id,name,avatar_url'), 201);
    }

    public function update(Request $request, string $id)
    {
        $post = MarketingPost::findOrFail($id);

        $validated = $request->validate([
            'title'        => 'sometimes|required|string|max:255',
            'caption'      => 'nullable|string',
            'channel'      => 'nullable|string|max:50',
            'scheduled_at' => 'nullable|date',
            'status'       => 'nullable|in:idea,scheduled,published',
        ]);

        if ($request->hasFile('image')) {
            $validated['image_path'] = $request->file('image')->store('marketing-posts', 'public');
        }

        $post->update($validated);

        return response()->json($post->load('user:id,name,avatar_url'));
    }

    public function destroy(string $id)
    {
        MarketingPost::findOrFail($id)->delete();

        return response()->json(['message' => 'Post removido com sucesso']);
    }
}
