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
        Schema::table('pecs_card_categories', function (Blueprint $table) {
            if (Schema::hasColumn('pecs_card_categories', 'code')) {
                $table->dropColumn('code');
            }
        });
    }

    public function down(): void
    {
        Schema::table('pecs_card_categories', function (Blueprint $table) {
            if (!Schema::hasColumn('pecs_card_categories', 'code')) {
                $table->integer('code')->after('name');
            }
    
        });
    }
};