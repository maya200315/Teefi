<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pecs_cards', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('image');
            $table->foreignId('PECS_card_categoryid')->constrained('pecs_card_categories')->onDelete('cascade');
            $table->timestamps();
        });
    }
 
    public function down(): void
    {
        Schema::dropIfExists('pecs_cards');
    }
};
