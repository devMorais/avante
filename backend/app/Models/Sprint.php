<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sprint extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id',
        'name',
        'start_date',
        'end_date',
        'finished_at',
    ];

    protected $casts = [
        'start_date'  => 'date',
        'end_date'    => 'date',
        'finished_at' => 'datetime',
    ];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

    public function isFinished(): bool
    {
        return !is_null($this->finished_at);
    }

    public function isOverdue(): bool
    {
        if ($this->isFinished()) return false;
        if (!$this->end_date) return false;
        return $this->end_date->isPast();
    }
}
