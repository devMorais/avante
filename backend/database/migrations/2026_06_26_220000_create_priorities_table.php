<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    private array $defaults = [
        ['name' => 'Baixa',   'color' => '#059669'],
        ['name' => 'Média',   'color' => '#0284C7'],
        ['name' => 'Alta',    'color' => '#EA580C'],
        ['name' => 'Urgente', 'color' => '#DC2626'],
    ];

    public function up(): void
    {
        Schema::create('priorities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('board_id')->constrained()->cascadeOnDelete();
            $table->string('name');
            $table->string('color', 7)->default('#6B6B70');
            $table->unsignedInteger('order')->default(0);
            $table->softDeletes();
            $table->timestamps();
        });

        // Cria prioridades padrão para todos os boards existentes
        $boardIds = DB::table('boards')->whereNull('deleted_at')->pluck('id');
        foreach ($boardIds as $boardId) {
            foreach ($this->defaults as $index => $p) {
                DB::table('priorities')->insert([
                    'board_id'   => $boardId,
                    'name'       => $p['name'],
                    'color'      => $p['color'],
                    'order'      => $index,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('priorities');
    }
};
