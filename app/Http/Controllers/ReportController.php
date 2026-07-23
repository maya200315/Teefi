<?php

namespace App\Http\Controllers;

use App\Services\BehaviorStatsService;
use App\Services\ReportGeneratorService;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class ReportController extends Controller
{
    public function __construct(
        private ReportGeneratorService $generator,
        private BehaviorStatsService $stats,
    ) {}

    // GET /api/children/{childId}/reports/weekly
    public function weekly(Request $request, int $childId)
    {
        $date = $request->query('date') ? Carbon::parse($request->query('date')) : now();

        $report = $this->generator->generateWeekly($childId, $date);

        return response()->json(['status' => true, 'data' => $report]);
    }

    // GET /api/children/{childId}/reports/monthly
    public function monthly(Request $request, int $childId)
    {
        $date = $request->query('date') ? Carbon::parse($request->query('date')) : now();

        $report = $this->generator->generateMonthly($childId, $date);

        return response()->json(['status' => true, 'data' => $report]);
    }

    // GET /api/children/{childId}/reports/chart?period=weekly|monthly
// بيرجع 4 أعمدة ثابتة (نوبة غضب / تفاعل إيجابي / سلوك تكراري / استجابة)
// تمثل العدد والنسبة الإجمالية لكل سلوك خلال الفترة المختارة بالكامل (مش تفصيل يومي)
public function chart(Request $request, int $childId)
{
    $period = $request->query('period', 'weekly');
    $referenceDate = $request->query('date') ? Carbon::parse($request->query('date')) : now();

    if ($period === 'monthly') {
        $start = $referenceDate->copy()->startOfMonth();
        $end   = $referenceDate->copy()->endOfMonth();
    } else {
        $start = $referenceDate->copy()->startOfWeek();
        $end   = $referenceDate->copy()->endOfWeek();
    }

    $stats = $this->stats->getStats($childId, $start, $end);

    $labels = [
        'anger'      => 'نوبة غضب',
        'positive'   => 'تفاعل إيجابي',
        'repetitive' => 'سلوك تكراري',
        'response'   => 'استجابة',
    ];

    $typeMap = [
        'anger'      => BehaviorStatsService::TYPE_ANGER,
        'positive'   => BehaviorStatsService::TYPE_POSITIVE,
        'repetitive' => BehaviorStatsService::TYPE_REPETITIVE,
        'response'   => BehaviorStatsService::TYPE_RESPONSE,
    ];

    $columns = [];
    foreach ($labels as $key => $label) {
        $columns[] = [
            'key'        => $key,
            'label'      => $label,
            'count'      => $stats['counts'][$typeMap[$key]] ?? 0,
            'percentage' => round($stats['percentages'][$key], 1),
        ];
    }

    return response()->json([
        'status' => true,
        'data'   => [
            'period'  => $period,
            'start'   => $start->toDateString(),
            'end'     => $end->toDateString(),
            'total'   => $stats['total'],
            'columns' => $columns,
        ],
    ]);
}
}
