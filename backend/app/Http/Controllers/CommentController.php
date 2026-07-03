<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\Notification;
use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class CommentController extends Controller
{
    public function index(Task $task)
    {
        return $task->comments()->with('user:id,name,email,avatar_url')->get();
    }

    public function store(Request $request, Task $task)
    {
        $validated = $request->validate([
            'content' => 'required|string',
        ]);

        $author = $request->user();

        $comment = $task->comments()->create([
            'content' => $validated['content'],
            'user_id' => $author->id,
        ]);

        $this->notifyParticipants($task, $comment, $author);

        return $comment->load('user:id,name,email,avatar_url');
    }

    public function destroy(Comment $comment)
    {
        $comment->delete();

        return response()->noContent();
    }

    /**
     * Notifica responsáveis pela tarefa, outros que já comentaram e menções
     * (@Nome) presentes no texto do comentário — exceto o próprio autor.
     */
    private function notifyParticipants(Task $task, Comment $comment, User $author): void
    {
        $recipients = [];

        foreach ($task->assignees as $assignee) {
            if ($assignee->id !== $author->id) {
                $recipients[$assignee->id] = 'comment';
            }
        }

        $commenterIds = $task->comments()->distinct()->pluck('user_id');
        foreach ($commenterIds as $userId) {
            if ($userId !== $author->id) {
                $recipients[$userId] ??= 'comment';
            }
        }

        $others = User::where('id', '!=', $author->id)->get(['id', 'name']);
        foreach ($others as $user) {
            $firstName = Str::of($user->name)->trim()->explode(' ')->first();
            if (Str::contains($comment->content, '@' . $user->name, true)
                || Str::contains($comment->content, '@' . $firstName, true)) {
                $recipients[$user->id] = 'mention';
            }
        }

        $snippet = Str::limit($comment->content, 80);

        foreach ($recipients as $userId => $type) {
            $message = $type === 'mention'
                ? "{$author->name} mencionou você em um comentário: \"{$snippet}\""
                : "{$author->name} comentou: \"{$snippet}\"";

            Notification::create([
                'user_id' => $userId,
                'task_id' => $task->id,
                'from_user_id' => $author->id,
                'type' => $type,
                'message' => $message,
            ]);
        }
    }
}
