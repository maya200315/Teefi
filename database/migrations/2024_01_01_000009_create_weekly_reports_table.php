<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('weekly_reports', function (Blueprint $table) {
            $table->id();
            $table->date('week_start');
            $table->date('week_end');
            $table->integer('total_behaviors')->default(0);
            $table->integer('positive_count')->default(0);
            $table->integer('negative_count')->default(0);
            $table->string('summary')->nullable();
            $table->foreignId('Childid')->constrained('children')->cascadeOnDelete();
            $table->foreignId('Userid')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
            $table->unique(['Childid', 'week_start', 'week_end']);
        });
    } 

    public function down(): void
    {
        Schema::dropIfExists('weekly_reports');
    }
};
