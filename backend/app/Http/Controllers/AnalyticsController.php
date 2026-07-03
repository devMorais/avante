<?php

namespace App\Http\Controllers;

use App\Models\Priority;
use App\Models\Sprint;
use App\Models\Status;
use App\Models\Task;
use App\Models\TaskType;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class AnalyticsController extends Controller
{
    public function board(string $boardId)
    {
        $boardId = (int) $boardId;

        return response()->json([
            'distribution'  => $this->distribution($boardId),
            'velocity'      => $this->velocity($boardId),
            'workload'      => $this->workload($boardId),
            'burndown'      => $this->burndown($boardId),
            'cycle_time'    => $this->cycleTime($boardId),
        ]);
    }

    private function distribution(int $boardId): array
    {
        $tasks = Task::where('board_id', $boardId)->get(['status_id', 'priority', 'type']);

        $statuses = Status::where('board_id', $boardId)->get(['id', 'name', 'color']);
        $byStatus = $statuses->map(fn($s) => [
            'name'  => $s->name,
            'color' => $s->color,
            'count' => $tasks->where('status_id', $s->id)->count(),
        ])->values();

        $priorities = Priority::where('board_id', $boardId)->get(['name', 'color']);
        $byPriority = $priorities->map(fn($p) => [
            'name'  => $p->name,
            'color' => $p->color,
            'count' => $tasks->where('priority', $p->name)->count(),
        ])->values();

        $types = TaskType::where('board_id', $boardId)->get(['name', 'color']);
        $byType = $types->map(fn($t) => [
            'name'  => $t->name,
            'color' => $t->color,
            'count' => $tasks->where('type', $t->name)->count(),
        ])->values();

        return [
            'by_status'   => $byStatus,
            'by_priority' => $byPriority,
            'by_type'     => $byType,
            'total'       => $tasks->count(),
        ];
    }

    private function velocity(int $boardId): array
    {
        $sprints = Sprint::where('board_id', $boardId)->orderBy('start_date')->get();

        return $sprints->map(function ($sprint) {
            $total = Task::where('sprint_id', $sprint->id)->count();
            $completed = Task::where('sprint_id', $sprint->id)->whereNotNull('completed_at')->count();

            return [
                'sprint_id'   => $sprint->id,
                'sprint_name' => $sprint->name,
                'total'       => $total,
                'completed'   => $completed,
            ];
        })->values()->toArray();
    }

    private function workload(int $boardId): array
    {
        $concludedId = Status::concludedIdFor($boardId);

        $rows = DB::table('task_user')
            ->join('tasks', 'tasks.id', '=', 'task_user.task_id')
            ->join('users', 'users.id', '=', 'task_user.user_id')
            ->where('tasks.board_id', $boardId)
            ->whereNull('tasks.deleted_at')
            ->select('users.id', 'users.name', 'users.avatar_url', 'tasks.status_id')
            ->get();

        $grouped = $rows->groupBy('id');

        return $grouped->map(function ($items, $userId) use ($concludedId) {
            $total = $items->count();
            $open = $concludedId
                ? $items->where('status_id', '!=', $concludedId)->count()
                : $total;

            return [
                'user_id'    => $userId,
                'name'       => $items->first()->name,
                'avatar_url' => $items->first()->avatar_url,
                'total'      => $total,
                'open'       => $open,
            ];
        })->sortByDesc('open')->values()->toArray();
    }

    private function burndown(int $boardId): ?array
    {
        $today = Carbon::today();

        $sprint = Sprint::where('board_id', $boardId)
            ->whereNull('finished_at')
            ->whereNotNull('start_date')
            ->whereNotNull('end_date')
            ->where('start_date', '<=', $today)
            ->orderBy('end_date')
            ->first()
            ?? Sprint::where('board_id', $boardId)
                ->whereNull('finished_at')
                ->whereNotNull('start_date')
                ->orderBy('start_date')
                ->first();

        if (!$sprint || !$sprint->start_date) {
            return null;
        }

        $start = Carbon::parse($sprint->start_date)->startOfDay();
        $end = $sprint->end_date ? Carbon::parse($sprint->end_date)->startOfDay() : $today->copy()->addDays(7);
        $totalTasks = Task::where('sprint_id', $sprint->id)->count();

        $completions = Task::where('sprint_id', $sprint->id)
            ->whereNotNull('completed_at')
            ->pluck('completed_at')
            ->map(fn($d) => Carbon::parse($d)->startOfDay());

        $totalDays = max(1, $start->diffInDays($end));
        $series = [];
        $cursor = $start->copy();
        $dayIndex = 0;

        while ($cursor->lte($end) && $dayIndex <= $totalDays) {
            $completedByThen = $completions->filter(fn($d) => $d->lte($cursor))->count();
            $series[] = [
                'date'      => $cursor->toDateString(),
                'remaining' => max(0, $totalTasks - $completedByThen),
                'ideal'     => round($totalTasks - ($totalTasks * ($dayIndex / $totalDays)), 1),
            ];
            $cursor->addDay();
            $dayIndex++;
        }

        return [
            'sprint_id'   => $sprint->id,
            'sprint_name' => $sprint->name,
            'start_date'  => $sprint->start_date,
            'end_date'    => $sprint->end_date,
            'total_tasks' => $totalTasks,
            'series'      => $series,
        ];
    }

    private function cycleTime(int $boardId): array
    {
        $tasks = Task::where('board_id', $boardId)
            ->whereNotNull('completed_at')
            ->get(['created_at', 'completed_at']);

        if ($tasks->isEmpty()) {
            return ['avg_hours' => null, 'avg_days' => null, 'sample_size' => 0];
        }

        $totalHours = $tasks->sum(fn($t) => Carbon::parse($t->created_at)->diffInHours(Carbon::parse($t->completed_at)));
        $avgHours = round($totalHours / $tasks->count(), 1);

        return [
            'avg_hours'   => $avgHours,
            'avg_days'    => round($avgHours / 24, 1),
            'sample_size' => $tasks->count(),
        ];
    }
}
