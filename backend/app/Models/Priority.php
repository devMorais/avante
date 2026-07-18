<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Priority extends Model
{
    use SoftDeletes;

    protected $fillable = ['board_id', 'area', 'name', 'color', 'order'];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
