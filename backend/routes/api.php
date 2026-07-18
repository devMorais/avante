<?php

use App\Http\Controllers\AnalyticsController;
use App\Http\Controllers\AttachmentController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BoardController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\MarketingCampaignController;
use App\Http\Controllers\MarketingIdeaController;
use App\Http\Controllers\MarketingLeadController;
use App\Http\Controllers\MarketingMetricController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\SprintController;
use App\Http\Controllers\PriorityController;
use App\Http\Controllers\StatusController;
use App\Http\Controllers\TagController;
use App\Http\Controllers\TaskTypeController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProfileController;

Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('/logout', [AuthController::class, 'logout']);

    Route::patch('/boards/{board}/archive', [BoardController::class, 'archive']);
    Route::patch('/boards/{board}/unarchive', [BoardController::class, 'unarchive']);
    Route::apiResource('boards', BoardController::class);

    Route::post('/tasks/reorder', [TaskController::class, 'reorder']);
    Route::post('/tasks/bulk-update', [TaskController::class, 'bulkUpdate']);
    Route::apiResource('tasks', TaskController::class);
    Route::get('/tasks/{task}/comments', [CommentController::class, 'index']);
    Route::post('/tasks/{task}/comments', [CommentController::class, 'store']);
    Route::delete('/comments/{comment}', [CommentController::class, 'destroy']);

    Route::get('/tasks/{task}/attachments', [AttachmentController::class, 'index']);
    Route::post('/tasks/{task}/attachments', [AttachmentController::class, 'store']);
    Route::delete('/attachments/{attachment}', [AttachmentController::class, 'destroy']);

    Route::apiResource('sprints', SprintController::class);
    Route::post('/sprints/{id}/finish', [SprintController::class, 'finish']);

    Route::put('/statuses/reorder', [StatusController::class, 'reorder']);
    Route::apiResource('statuses', StatusController::class);

    Route::put('/priorities/reorder', [PriorityController::class, 'reorder']);
    Route::apiResource('priorities', PriorityController::class);

    Route::put('/task-types/reorder', [TaskTypeController::class, 'reorder']);
    Route::apiResource('task-types', TaskTypeController::class);

    Route::apiResource('tags', TagController::class);

    Route::apiResource('users', UserController::class);

    // Notificações
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::get('/notifications/unread-count', [NotificationController::class, 'unreadCount']);
    Route::post('/notifications/read-all', [NotificationController::class, 'markAllRead']);
    Route::post('/notifications/{id}/read', [NotificationController::class, 'markRead']);

    // Marketing
    Route::apiResource('marketing-leads', MarketingLeadController::class)->except(['show']);
    Route::apiResource('marketing-ideas', MarketingIdeaController::class)->except(['show']);
    Route::post('/marketing-ideas/{id}/upvote', [MarketingIdeaController::class, 'upvote']);
    Route::apiResource('marketing-campaigns', MarketingCampaignController::class)->except(['show']);
    Route::apiResource('marketing-metrics', MarketingMetricController::class)->except(['show', 'update']);

    // Analytics
    Route::get('/analytics/board/{boardId}', [AnalyticsController::class, 'board']);

    // Profile
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::put('/profile', [ProfileController::class, 'update']);
    Route::post('/profile/password', [ProfileController::class, 'updatePassword']);
    Route::post('/profile/avatar', [ProfileController::class, 'uploadAvatar']);
});
