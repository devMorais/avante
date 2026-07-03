<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MarketingLead extends Model
{
    use SoftDeletes;

    protected $fillable = ['board_id', 'name', 'contact', 'stage', 'value', 'notes'];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
