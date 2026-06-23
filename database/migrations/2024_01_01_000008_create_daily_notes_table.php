<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('daily_notes', function (Blueprint $table) {
            $table->id();
            $table->string('note');
            $table->date('date');
            $table->foreignId('Userid')->constrained('users')->onDelete('cascade');
            $table->foreignId('Childid')->constrained('children')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('daily_notes');
    }
};
