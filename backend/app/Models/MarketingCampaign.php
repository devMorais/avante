<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MarketingCampaign extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id', 'name', 'channels', 'budget', 'start_date', 'end_date', 'goal', 'status',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
