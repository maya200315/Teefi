<?php

namespace App\Http\Controllers;

use App\Services\BehaviorStatsService;
use App\Services\ReportGeneratorService;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class ReportParentController extends Controller
{
    public function __construct(
        private ReportGeneratorService $generator,
        private BehaviorStatsService $stats,
    ) {
    }

    public function weekly(Request $request, int $childId)
    {
        $date = $request->query('date')
            ? Carbon::parse($request->query('date'))
            : now();

        $report = $this->generator->generateWeekly($childId, $date);

        return response()->json([
            'status' => true,
            'data' => $report,
        ]);
    }

    public function monthly(Request $request, int $childId)
    {
        $date = $request->query('date')
            ? Carbon::parse($request->query('date'))
            : now();

        $report = $this->generator->generateMonthly($childId, $date);

        return response()->json([
            'status' => true,
            'data' => $report,
        ]);
    }

    // يرجع 4 أعمدة ثابتة تمثل العدد والنسبة الإجمالية لكل سلوك خلال الفترة المختارة
    public function chart(Request $request, int $childId)
    {
        $period = $request->query('period', 'weekly');

        $referenceDate = $request->query('date')
            ? Carbon::parse($request->query('date'))
            : now();

        if ($period === 'monthly') {
            $start = $referenceDate->copy()->startOfMonth();
            $end = $referenceDate->copy()->endOfMonth();
        } else {
            $start = $referenceDate->copy()->startOfWeek();
            $end = $referenceDate->copy()->endOfWeek();
        }

        $stats = $this->stats->getStats($childId, $start, $end);

        $labels = [
            'anger' => 'نوبة غضب',
            'positive' => 'تفاعل إيجابي',
            'repetitive' => 'سلوك تكراري',
            'response' => 'استجابة',
        ];

        $typeMap = [
            'anger' => BehaviorStatsService::TYPE_ANGER,
            'positive' => BehaviorStatsService::TYPE_POSITIVE,
            'repetitive' => BehaviorStatsService::TYPE_REPETITIVE,
            'response' => BehaviorStatsService::TYPE_RESPONSE,
        ];

        $columns = [];

        foreach ($labels as $key => $label) {
            $columns[] = [
                'key' => $key,
                'label' => $label,
                'count' => $stats['counts'][$typeMap[$key]] ?? 0,
                'percentage' => round($stats['percentages'][$key] ?? 0, 1),
            ];
        }

        return response()->json([
            'status' => true,
            'data' => [
                'period' => $period,
                'start' => $start->toDateString(),
                'end' => $end->toDateString(),
                'total' => $stats['total'] ?? 0,
                'columns' => $columns,
            ],
        ]);
    }
}