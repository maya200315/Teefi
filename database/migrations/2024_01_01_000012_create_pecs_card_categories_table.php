<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pecs_card_categories', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('code');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pecs_card_categories');
    }
};
