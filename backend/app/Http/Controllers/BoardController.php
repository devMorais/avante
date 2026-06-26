<?php

namespace App\Http\Controllers;

use App\Models\Board;
use App\Models\Priority;
use App\Models\Status;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class BoardController extends Controller
{
    /**
     * Status padrão criados automaticamente para todo quadro novo.
     */
    private const DEFAULT_STATUSES = [
        ['name' => 'Em Fila', 'color' => '#6B6B70'],
        ['name' => 'Em Andamento', 'color' => '#0284C7'],
        ['name' => 'Em Revisão', 'color' => '#D97706'],
        ['name' => 'Concluída', 'color' => '#059669'],
    ];

    /**
     * Prioridades padrão criadas automaticamente para todo quadro novo.
     */
    private const DEFAULT_PRIORITIES = [
        ['name' => 'Baixa', 'color' => '#059669'],
        ['name' => 'Média', 'color' => '#0284C7'],
        ['name' => 'Alta', 'color' => '#EA580C'],
        ['name' => 'Urgente', 'color' => '#DC2626'],
    ];

    /**
     * Monta a URL completa (com domínio) para o ícone do board.
     * Storage::url() sozinho devolve só o caminho relativo (/storage/...),
     * o que quebra no frontend porque o navegador completa com o domínio
     * do Angular (localhost:4200) em vez do Laravel (gestao-tarefas.test).
     */
    private function buildIconUrl(?string $iconPath): ?string
    {
        if (!$iconPath) {
            return null;
        }

        return rtrim(config('app.url'), '/') . Storage::url($iconPath);
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $boards = Board::orderByDesc('created_at')->get()->map(function ($board) {
            $board->icon_url = $this->buildIconUrl($board->icon_path);
            return $board;
        });

        return response()->json($boards);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:4096', // 4MB
        ]);

        $iconPath = null;

        if ($request->hasFile('image')) {
            // Salva em storage/app/public/boards e retorna o caminho relativo
            $iconPath = $request->file('image')->store('boards', 'public');
        }

        $board = Board::create([
            'name' => $validated['name'],
            'icon_path' => $iconPath,
        ]);

        // Cria os status padrão para este quadro (Em Fila, Em Andamento, etc.)
        foreach (self::DEFAULT_STATUSES as $index => $status) {
            Status::create([
                'board_id' => $board->id,
                'name' => $status['name'],
                'color' => $status['color'],
                'order' => $index,
            ]);
        }

        // Cria as prioridades padrão para este quadro
        foreach (self::DEFAULT_PRIORITIES as $index => $priority) {
            Priority::create([
                'board_id' => $board->id,
                'name' => $priority['name'],
                'color' => $priority['color'],
                'order' => $index,
            ]);
        }

        $board->icon_url = $this->buildIconUrl($board->icon_path);

        return response()->json($board, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $board = Board::findOrFail($id);
        $board->icon_url = $this->buildIconUrl($board->icon_path);

        return response()->json($board);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $board = Board::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'image' => 'nullable|image|mimes:jpg,jpeg,png,webp|max:4096',
        ]);

        if ($request->hasFile('image')) {
            // Remove a imagem antiga, se existir, antes de salvar a nova
            if ($board->icon_path) {
                Storage::disk('public')->delete($board->icon_path);
            }
            $validated['icon_path'] = $request->file('image')->store('boards', 'public');
        }

        $board->update($validated);
        $board->icon_url = $this->buildIconUrl($board->icon_path);

        return response()->json($board);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $board = Board::findOrFail($id);

        if ($board->icon_path) {
            Storage::disk('public')->delete($board->icon_path);
        }

        $board->delete();

        return response()->json(null, 204);
    }
}
