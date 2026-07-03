<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MarketingIdea extends Model
{
    use SoftDeletes;

    protected $fillable = ['board_id', 'title', 'description', 'votes', 'tags'];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
