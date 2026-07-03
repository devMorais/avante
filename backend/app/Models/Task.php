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
        'release',
        'type',
        'notes',
        'sort_order',
        'completed_at',
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

    public function assignee()
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function assignees()
    {
        return $this->belongsToMany(User::class, 'task_user')
            ->select(['users.id', 'users.name', 'users.email', 'users.avatar_url']);
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'task_tag')
            ->select(['tags.id', 'tags.name', 'tags.color']);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class)->orderBy('created_at');
    }

    public function attachments()
    {
        return $this->hasMany(Attachment::class);
    }
}
