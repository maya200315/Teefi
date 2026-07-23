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
    // بيرجع بيانات الأعمدة اليومية جاهزة للرسم البياني بالواجهة
    public function chart(Request $request, int $childId)
    {
        $period = $request->query('period', 'weekly');
        $end    = now()->endOfDay();
        $start  = $period === 'monthly'
            ? now()->startOfMonth()
            : now()->startOfWeek();

        $days = [];
        for ($day = $start->copy(); $day->lte($end); $day->addDay()) {
            $dayStats = $this->stats->getStats($childId, $day->copy()->startOfDay(), $day->copy()->endOfDay());
            $days[] = [
                'date'        => $day->toDateString(),
                'percentages' => $dayStats['percentages'],
            ];
        }

        return response()->json(['status' => true, 'data' => $days]);
    }
}
