<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('behaviors', function (Blueprint $table) {
            // مين سجّل هالسلوك (أهل أو أخصائي) - كلاهما موجود بجدول users
            $table->foreignId('Userid')
                ->nullable()
                ->after('Childid')
                ->constrained('users')
                ->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::table('behaviors', function (Blueprint $table) {
            $table->dropForeign(['Userid']);
            $table->dropColumn('Userid');
        });
    }
};
