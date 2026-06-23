<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('tasks', function (Blueprint $table) {
            $table->foreignId('sprint_id')->nullable()->after('board_id')
                ->constrained('sprints')->onDelete('set null');

            $table->foreignId('assigned_to')->nullable()->after('sprint_id')
                ->constrained('users')->onDelete('set null');

            $table->text('description')->nullable()->after('title');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('tasks', function (Blueprint $table) {
            $table->dropForeign(['sprint_id']);
            $table->dropForeign(['assigned_to']);
            $table->dropColumn(['sprint_id', 'assigned_to', 'description']);
        });
    }
};
