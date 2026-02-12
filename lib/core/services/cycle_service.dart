import 'package:periodility/features/cycle/domain/entities/cycle_entity.dart';

class CycleService {
  static const int ovulationBeforeNextPeriod =
      14; // Овуляция обычно за 14 дней до конца
  static const int fertileWindowRange = 3; // +/- дни от овуляции

  /// Рассчитываем текущую фазу
  CyclePhase getPhase(DateTime date, CycleEntity current, int avgLength) {
    final dayOfCycle = date.difference(current.startDate).inDays + 1;

    // 1. Менструация (если еще не ввели дату окончания, считаем по среднему, напр. 5 дней)
    final periodDuration =
        current.endDate?.difference(current.startDate).inDays ?? 5;
    if (dayOfCycle <= periodDuration) return CyclePhase.menstruation;

    // 2. Овуляция (рассчитываем от прогнозируемого конца цикла)
    final ovulationDay = avgLength - ovulationBeforeNextPeriod;
    if (dayOfCycle >= ovulationDay - 1 && dayOfCycle <= ovulationDay + 1) {
      return CyclePhase.ovulation;
    }

    // 3. Все что до овуляции — фолликулярная, после — лютеиновая
    return dayOfCycle < ovulationDay
        ? CyclePhase.follicular
        : CyclePhase.luteal;
  }

  /// Проверка на фертильность (окно зачатия)
  bool isFertile(DateTime date, CycleEntity current, int avgLength) {
    final dayOfCycle = date.difference(current.startDate).inDays + 1;
    final ovulationDay = avgLength - ovulationBeforeNextPeriod;

    return dayOfCycle >= (ovulationDay - 5) && dayOfCycle <= (ovulationDay + 1);
  }
}
