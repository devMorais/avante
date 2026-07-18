<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TaskType extends Model
{
    use SoftDeletes;

    protected $table = 'task_types';

    protected $fillable = ['board_id', 'area', 'name', 'color', 'order'];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
