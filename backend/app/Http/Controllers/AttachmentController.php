<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Models\Attachment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class AttachmentController extends Controller
{
    public function index(Task $task)
    {
        return $task->attachments()->with('user:id,name,avatar_url')->latest()->get();
    }

    public function store(Request $request, Task $task)
    {
        $request->validate([
            'file' => 'required|file|max:10240', // 10MB — qualquer tipo, arquivo oficial da tarefa
        ]);

        $file = $request->file('file');
        $path = $file->store('task-attachments', 'public');

        $attachment = $task->attachments()->create([
            'user_id'       => $request->user()->id,
            'path'          => $path,
            'original_name' => $file->getClientOriginalName(),
            'size'          => $file->getSize(),
            'mime_type'     => $file->getClientMimeType(),
        ]);

        return response()->json($attachment->load('user:id,name,avatar_url'), 201);
    }

    public function destroy(Attachment $attachment)
    {
        Storage::disk('public')->delete($attachment->path);
        $attachment->delete();

        return response()->noContent();
    }
}
