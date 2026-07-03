<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Status extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id',
        'name',
        'color',
        'order',
    ];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

    /**
     * ID do status considerado "concluído" de um board, pelo nome
     * (Concluído/Concluido/Done/Finalizado) — usado ao finalizar sprint
     * e para marcar tasks.completed_at automaticamente.
     */
    public static function concludedIdFor(int $boardId): ?int
    {
        return static::where('board_id', $boardId)
            ->whereRaw("LOWER(name) IN ('concluído', 'concluido', 'done', 'finalizado')")
            ->value('id');
    }
}
