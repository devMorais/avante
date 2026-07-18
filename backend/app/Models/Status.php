<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Status extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id',
        'area',
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
     * ID do status considerado "concluído" de um board+área, pelo nome
     * (Concluído/Concluido/Done/Finalizado/Publicado) — usado ao finalizar
     * sprint e para marcar tasks.completed_at automaticamente. "Publicado"
     * cobre o status final do fluxo de marketing.
     */
    public static function concludedIdFor(int $boardId, string $area = 'programming'): ?int
    {
        return static::where('board_id', $boardId)
            ->where('area', $area)
            ->whereRaw("LOWER(name) IN ('concluído', 'concluido', 'done', 'finalizado', 'publicado', 'publicada')")
            ->value('id');
    }
}
