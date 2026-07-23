<?php

namespace App\Services;

class BehaviorSummaryService
{
    // نسبة التكرارية اللي فوقها منضيف ملاحظة إضافية بالملخص
    private const REPETITIVE_HIGH_THRESHOLD = 35;

    // حدود الفرق بين (استجابة + تفاعل إيجابي) و (نوبة غضب)
    private const STRONG_THRESHOLD = 20;
    private const MILD_THRESHOLD   = 5;

    /**
     * بياخد نسب مئوية جاهزة (من BehaviorStatsService) ويرجع نص الملخص.
     * ما إلها علاقة بالداتابيز أو الفترة الزمنية — هيك منقدر نعيد استخدامها
     * بأي مكان: on-demand، scheduled job، أو حتى تست.
     *
     * @param array{total:int, percentages: array{anger:float, positive:float, repetitive:float, response:float}} $stats
     */
    public function generate(array $stats): string
    {
        if ($stats['total'] === 0) {
            return 'لا توجد بيانات كافية لهذه الفترة لتوليد ملخص.';
        }

        $p = $stats['percentages'];
        $diff = ($p['positive'] + $p['response']) - $p['anger'];

        $mainSentence  = $this->pickMainSentence($diff);
        $extraSentence = $p['repetitive'] >= self::REPETITIVE_HIGH_THRESHOLD
            ? $this->pickRepetitiveSentence()
            : null;

        return $extraSentence ? "$mainSentence $extraSentence" : $mainSentence;
    }

    private function pickMainSentence(float $diff): string
    {
        if ($diff >= self::STRONG_THRESHOLD) {
            return $this->randomFrom([
                'لوحظ استجابة وتحسن ملحوظ في سلوك الطفل خلال هذه الفترة.',
                'أظهر الطفل تفاعلاً إيجابياً واستجابة جيدة بشكل واضح.',
            ]);
        }

        if ($diff >= self::MILD_THRESHOLD) {
            return $this->randomFrom([
                'لوحظ تحسن بسيط في استجابة الطفل وتفاعله الإيجابي.',
                'أظهر الطفل تحسناً طفيفاً في السلوك خلال هذه الفترة.',
            ]);
        }

        if ($diff <= -self::STRONG_THRESHOLD) {
            return $this->randomFrom([
                'لوحظ تراجع ونوبات غضب متكررة خلال هذه الفترة.',
                'أظهر الطفل نوبات غضب ملحوظة تستدعي المتابعة.',
            ]);
        }

        if ($diff <= -self::MILD_THRESHOLD) {
            return $this->randomFrom([
                'لوحظ ارتفاع طفيف في نوبات الغضب مقارنة بالاستجابة الإيجابية.',
                'ظهرت بعض نوبات الغضب بشكل أعلى قليلاً من المعتاد.',
            ]);
        }

        return $this->randomFrom([
            'لوحظ تنوع في سلوكيات الطفل دون وجود اتجاه واضح خلال هذه الفترة.',
            'تباينت سلوكيات الطفل بين الإيجابي والسلبي بنسب متقاربة.',
        ]);
    }

    private function pickRepetitiveSentence(): string
    {
        return $this->randomFrom([
            'كما لوحظ ارتفاع في السلوكيات التكرارية خلال هذه الفترة.',
            'مع ملاحظة تكرار بعض الحركات أو السلوكيات بشكل متكرر.',
        ]);
    }

    private function randomFrom(array $options): string
    {
        return $options[array_rand($options)];
    }
}
