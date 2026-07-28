<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('behavior_types', function (Blueprint $table) {
            // بدل change() اللي بتحتاج doctrine/dbal:
            // بنحذف العمود القديم (الإجباري) ونضيفه من جديد اختياري
            $table->dropForeign(['Userid']);
            $table->dropColumn('Userid');
        });

        Schema::table('behavior_types', function (Blueprint $table) {
            $table->foreignId('Userid')->nullable()->after('name')->constrained('users')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('behavior_types', function (Blueprint $table) {
            $table->dropForeign(['Userid']);
            $table->dropColumn('Userid');
        });

        Schema::table('behavior_types', function (Blueprint $table) {
            $table->foreignId('Userid')->constrained('users')->onDelete('cascade');
        });
    }
};
 