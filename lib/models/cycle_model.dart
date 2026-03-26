enum DayPhase {
  none,
  periodLight,
  periodMid,
  periodPeak,
  fertilelow,
  fertileMid,
  fertilePeak,
  ovulation,
}

class CycleModel {
  final DateTime cycleStart;
  final int cycleLength;
  final int periodLength;

  const CycleModel({
    required this.cycleStart,
    this.cycleLength = 28,
    this.periodLength = 5,
  });

  int dayOfCycle(DateTime date) {
    final diff = date.difference(cycleStart).inDays % cycleLength;
    return diff < 0 ? diff + cycleLength : diff + 1;
  }

  DayPhase phaseOf(DateTime date) {
    final day = dayOfCycle(date);

    if (day == 1) return DayPhase.periodLight;
    if (day == 2) return DayPhase.periodPeak;
    if (day == 3) return DayPhase.periodMid;
    if (day <= periodLength) return DayPhase.periodLight;

    final ovulationDay = cycleLength - 14;
    if (day == ovulationDay) return DayPhase.ovulation;

    if (day == ovulationDay - 5) return DayPhase.fertilelow;
    if (day == ovulationDay - 4) return DayPhase.fertilelow;
    if (day == ovulationDay - 3) return DayPhase.fertileMid;
    if (day == ovulationDay - 2) return DayPhase.fertileMid;
    if (day == ovulationDay - 1) return DayPhase.fertilePeak;
    if (day == ovulationDay + 1) return DayPhase.fertileMid;

    return DayPhase.none;
  }
}