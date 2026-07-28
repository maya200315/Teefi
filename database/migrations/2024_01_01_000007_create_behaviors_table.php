<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('behaviors', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->string('notes');
            // $table->date('datetime');
            $table->foreignId('Behavior_typeid')->constrained('behavior_types')->onDelete('cascade');
            $table->foreignId('Childid')->constrained('children')->onDelete('cascade');
            $table->timestamps();
        });
    }
 
    public function down(): void
    {
        Schema::dropIfExists('behaviors');
    }
};
