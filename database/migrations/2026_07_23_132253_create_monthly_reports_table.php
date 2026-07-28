<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('monthly_reports', function (Blueprint $table) {
            $table->id();
            $table->date('month_start');
            $table->date('month_end');
            $table->unsignedInteger('total_behaviors')->default(0);
            $table->unsignedInteger('positive_count')->default(0);
            $table->unsignedInteger('negative_count')->default(0);
            $table->text('summary')->nullable();
            $table->foreignId('Childid')->constrained('children')->cascadeOnDelete();
            $table->foreignId('Userid')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();

            // ما بدنا نكرر نفس التقرير لنفس الطفل بنفس الشهر
            $table->unique(['Childid', 'month_start', 'month_end']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('monthly_reports');
    }
};
 