<?php

namespace App\Services;

use App\Models\Behavior;
use Illuminate\Support\Carbon;

class BehaviorStatsService
{
    // مطابقة لترتيب BehaviorTypeSeeder — تأكد منها بالداتابيز إذا تغيرت
    public const TYPE_ANGER      = 1; // نوبة غضب
    public const TYPE_POSITIVE   = 2; // تفاعل إيجابي
    public const TYPE_REPETITIVE = 3; // سلوك تكراري
    public const TYPE_RESPONSE   = 4; // استجابة

    /**
     * بيرجع مصفوفة فيها العدد والنسبة المئوية لكل نوع سلوك خلال فترة معينة.
     * هاي الدالة بتنستخدم لكل من: الرسم البياني، وتوليد الملخص، وأي تقرير مستقبلي.
     *
     * @return array{
     *   total: int,
     *   counts: array<int,int>,
     *   percentages: array{anger: float, positive: float, repetitive: float, response: float}
     * }
     */
    public function getStats(int $childId, Carbon $start, Carbon $end): array
    {
        $counts = Behavior::where('Childid', $childId)
            ->whereBetween('date', [$start->toDateString(), $end->toDateString()])
            ->selectRaw('Behavior_typeid, COUNT(*) as total')
            ->groupBy('Behavior_typeid')
            ->pluck('total', 'Behavior_typeid');

        $total = $counts->sum();

        $percentages = [
            'anger'      => $total ? ($counts[self::TYPE_ANGER]      ?? 0) / $total * 100 : 0,
            'positive'   => $total ? ($counts[self::TYPE_POSITIVE]   ?? 0) / $total * 100 : 0,
            'repetitive' => $total ? ($counts[self::TYPE_REPETITIVE] ?? 0) / $total * 100 : 0,
            'response'   => $total ? ($counts[self::TYPE_RESPONSE]   ?? 0) / $total * 100 : 0,
        ];

        return [
            'total'       => $total,
            'counts'      => $counts->toArray(),
            'percentages' => $percentages,
        ];
    }
}
