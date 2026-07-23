<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        // 1) قبل ما نضيف الـ unique constraint، لازم نتأكد ما في سجلات مكررة
        //    (نفس الطفل + نفس الأسبوع) موجودة أصلاً بالجدول، لأن الـ constraint
        //    ئرح يفشل لو في تكرار قائم فعلياً.
        $duplicates = DB::table('weekly_reports')
            ->select('Childid', 'week_start', 'week_end', DB::raw('COUNT(*) as total'))
            ->groupBy('Childid', 'week_start', 'week_end')
            ->having('total', '>', 1)
            ->get();

        if ($duplicates->isNotEmpty()) {
            // نحتفظ بأحدث سجل (أكبر id) لكل مجموعة مكررة، ونحذف الباقي
            foreach ($duplicates as $dup) {
                $idsToKeep = DB::table('weekly_reports')
                    ->where('Childid', $dup->Childid)
                    ->where('week_start', $dup->week_start)
                    ->where('week_end', $dup->week_end)
                    ->orderByDesc('id')
                    ->limit(1)
                    ->pluck('id');

                DB::table('weekly_reports')
                    ->where('Childid', $dup->Childid)
                    ->where('week_start', $dup->week_start)
                    ->where('week_end', $dup->week_end)
                    ->whereNotIn('id', $idsToKeep)
                    ->delete();
            }
        }

        // 2) ضيف الـ unique constraint بعد التأكد إنو ما في تكرار
        Schema::table('weekly_reports', function (Blueprint $table) {
            $table->unique(['Childid', 'week_start', 'week_end'], 'weekly_reports_child_week_unique');
        });
    }

    public function down(): void
    {
        Schema::table('weekly_reports', function (Blueprint $table) {
            $table->dropUnique('weekly_reports_child_week_unique');
        });
    }
};