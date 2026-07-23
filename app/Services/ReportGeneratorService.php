<?php

namespace App\Services;

use App\Models\MonthlyReport;
use App\Models\WeeklyReport;
use Illuminate\Support\Carbon;

class ReportGeneratorService
{
    public function __construct(
        private BehaviorStatsService $stats,
        private BehaviorSummaryService $summary,
    ) {}

    /**
     * بيحسب وبيخزن (أو يحدّث) تقرير أسبوعي لطفل معيّن.
     * لو صار عندك استدعاء من كنترولر (on-demand) أو من Artisan command (scheduled)،
     * كلاهما بينادوا نفس الدالة هاي - صفر تكرار بالمنطق.
     */
    public function generateWeekly(int $childId, ?Carbon $referenceDate = null): WeeklyReport
    {
        $referenceDate ??= now();
        $weekStart = $referenceDate->copy()->startOfWeek();
        $weekEnd   = $referenceDate->copy()->endOfWeek();

        $stats       = $this->stats->getStats($childId, $weekStart, $weekEnd);
        $summaryText = $this->summary->generate($stats);

        return WeeklyReport::updateOrCreate(
            [
                'Childid'    => $childId,
                'week_start' => $weekStart->toDateString(),
                'week_end'   => $weekEnd->toDateString(),
            ],
            [
                'total_behaviors' => $stats['total'],
                'positive_count'  => ($stats['counts'][BehaviorStatsService::TYPE_POSITIVE] ?? 0)
                                    + ($stats['counts'][BehaviorStatsService::TYPE_RESPONSE] ?? 0),
                'negative_count'  => $stats['counts'][BehaviorStatsService::TYPE_ANGER] ?? 0,
                'summary'         => $summaryText,
            ]
        );
    }

    /**
     * نفس المنطق تماماً بس للتقرير الشهري.
     */
    public function generateMonthly(int $childId, ?Carbon $referenceDate = null): MonthlyReport
    {
        $referenceDate ??= now();
        $monthStart = $referenceDate->copy()->startOfMonth();
        $monthEnd   = $referenceDate->copy()->endOfMonth();

        $stats       = $this->stats->getStats($childId, $monthStart, $monthEnd);
        $summaryText = $this->summary->generate($stats);

        return MonthlyReport::updateOrCreate(
            [
                'Childid'     => $childId,
                'month_start' => $monthStart->toDateString(),
                'month_end'   => $monthEnd->toDateString(),
            ],
            [
                'total_behaviors' => $stats['total'],
                'positive_count'  => ($stats['counts'][BehaviorStatsService::TYPE_POSITIVE] ?? 0)
                                    + ($stats['counts'][BehaviorStatsService::TYPE_RESPONSE] ?? 0),
                'negative_count'  => $stats['counts'][BehaviorStatsService::TYPE_ANGER] ?? 0,
                'summary'         => $summaryText,
            ]
        );
    }
}
