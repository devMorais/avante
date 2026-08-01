<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('sprints', function (Blueprint $table) {
            $table->unsignedInteger('sort_order')->default(0)->after('end_date');
        });

        // Preenche sort_order pelas sprints existentes, mantendo a ordem atual (por start_date)
        // para não embaralhar nada já publicado.
        $boards = DB::table('sprints')->select('board_id')->distinct()->pluck('board_id');

        foreach ($boards as $boardId) {
            $sprints = DB::table('sprints')
                ->where('board_id', $boardId)
                ->orderByRaw('start_date IS NULL, start_date ASC')
                ->orderBy('id')
                ->get(['id']);

            foreach ($sprints as $index => $sprint) {
                DB::table('sprints')->where('id', $sprint->id)->update(['sort_order' => $index]);
            }
        }
    }

    public function down(): void
    {
        Schema::table('sprints', function (Blueprint $table) {
            $table->dropColumn('sort_order');
        });
    }
};
