<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pecs_card_child', function (Blueprint $table) {
            $table->id();
            $table->foreignId('PECS_cardid')->constrained('pecs_cards')->onDelete('cascade');
            $table->foreignId('Childid')->constrained('children')->onDelete('cascade');
            $table->timestamps();
        });
    } 

    public function down(): void
    {
        Schema::dropIfExists('pecs_card_child');
    }
};
