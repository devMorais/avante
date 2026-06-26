<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    private array $defaults = [
        ['name' => 'Tarefa',   'color' => '#6B6B70'],
        ['name' => 'História',  'color' => '#7C3AED'],
        ['name' => 'Bug',       'color' => '#DC2626'],
        ['name' => 'Melhoria',  'color' => '#0284C7'],
    ];

    public function up(): void
    {
        Schema::create('task_types', function (Blueprint $table) {
            $table->id();
            $table->foreignId('board_id')->constrained()->cascadeOnDelete();
            $table->string('name');
            $table->string('color', 7)->default('#6B6B70');
            $table->unsignedInteger('order')->default(0);
            $table->softDeletes();
            $table->timestamps();
        });

        Schema::table('tasks', function (Blueprint $table) {
            $table->string('type')->nullable()->after('release');
        });

        // Cria tipos padrão para todos os boards existentes
        $boardIds = DB::table('boards')->whereNull('deleted_at')->pluck('id');
        foreach ($boardIds as $boardId) {
            foreach ($this->defaults as $index => $t) {
                DB::table('task_types')->insert([
                    'board_id'   => $boardId,
                    'name'       => $t['name'],
                    'color'      => $t['color'],
                    'order'      => $index,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }

    public function down(): void
    {
        Schema::table('tasks', function (Blueprint $table) {
            $table->dropColumn('type');
        });
        Schema::dropIfExists('task_types');
    }
};
