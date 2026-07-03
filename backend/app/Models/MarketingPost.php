<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MarketingPost extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'board_id', 'user_id', 'title', 'caption', 'channel',
        'scheduled_at', 'status', 'image_path',
    ];

    protected $casts = [
        'scheduled_at' => 'datetime',
    ];

    protected $appends = ['image_url'];

    public function getImageUrlAttribute(): ?string
    {
        return $this->image_path ? url('storage/' . $this->image_path) : null;
    }

    public function board()
    {
        return $this->belongsTo(Board::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
