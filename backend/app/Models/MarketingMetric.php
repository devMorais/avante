<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MarketingMetric extends Model
{
    protected $fillable = ['board_id', 'channel', 'period_date', 'reach', 'engagement', 'conversions'];

    protected $casts = [
        'period_date' => 'date',
    ];

    public function board()
    {
        return $this->belongsTo(Board::class);
    }
}
