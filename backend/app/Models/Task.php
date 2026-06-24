<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Task extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id',
        'sprint_id',
        'status_id',
        'assigned_to',
        'description',
        'priority',
        'epic',
        'notes',
    ];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }

    public function sprint()
    {
        return $this->belongsTo(Sprint::class);
    }

    public function status()
    {
        return $this->belongsTo(Status::class);
    }

    // Mantido para compatibilidade com o campo legado
    public function assignee()
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    // Novo: múltiplos responsáveis via pivot
    public function assignees()
    {
        return $this->belongsToMany(User::class, 'task_user')
            ->select(['users.id', 'users.name', 'users.email']);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class)->orderBy('created_at');
    }
}
