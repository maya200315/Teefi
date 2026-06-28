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
    Schema::table('parentts', function (Blueprint $table) {
        $table->integer('age')->nullable()->after('autism_level');
    });
}

public function down(): void
{
    Schema::table('parentts', function (Blueprint $table) {
        $table->dropColumn('age');
    });
}
};
