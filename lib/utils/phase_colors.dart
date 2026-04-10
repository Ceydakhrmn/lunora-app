// =============================================
// utils/phase_colors.dart
// Her faza karşılık gelen renk ve metin bilgileri
// Renk değiştirmek istersen buradan yap
// =============================================

import 'package:flutter/material.dart';
import '../models/cycle_model.dart';

class PhaseStyle {
  final Color background;
  final Color textColor;
  final String label;

  const PhaseStyle({
    required this.background,
    required this.textColor,
    required this.label,
  });
}

// ---- Renk sabitleri ----
// Mor tonları — Regl günleri
const Color kPeriodLight = Color(0xFFC084FC); // açık mor
const Color kPeriodMid   = Color(0xFFA855F7); // orta mor
const Color kPeriodPeak  = Color(0xFF7C3AED); // koyu mor/lacivert

// Isı skalası — Doğurganlık
const Color kFertileLow  = Color(0xFFFDE047); // sarı
const Color kFertileMid  = Color(0xFFF97316); // turuncu
const Color kFertilePeak = Color(0xFFDC2626); // kırmızı

// Ovulasyon
const Color kOvulation   = Color(0xFF3B82F6); // mavi

// Karanlık metin renkleri
const Color kDarkText    = Color(0xFF1a1a1a);

PhaseStyle phaseStyle(DayPhase phase) {
  switch (phase) {
    case DayPhase.periodLight:
      return const PhaseStyle(
        background: kPeriodLight,
        textColor: Color(0xFF3b0764),
        label: 'Regl — hafif',
      );
    case DayPhase.periodMid:
      return const PhaseStyle(
        background: kPeriodMid,
        textColor: Colors.white,
        label: 'Regl — orta yoğunluk',
      );
    case DayPhase.periodPeak:
      return const PhaseStyle(
        background: kPeriodPeak,
        textColor: Colors.white,
        label: 'Regl — yoğun',
      );
    case DayPhase.fertilelow:
      return const PhaseStyle(
        background: kFertileLow,
        textColor: Color(0xFF713f12),
        label: 'Doğurganlık — düşük',
      );
    case DayPhase.fertileMid:
      return const PhaseStyle(
        background: kFertileMid,
        textColor: Colors.white,
        label: 'Doğurganlık — orta',
      );
    case DayPhase.fertilePeak:
      return const PhaseStyle(
        background: kFertilePeak,
        textColor: Colors.white,
        label: 'Doğurganlık — en yüksek',
      );
    case DayPhase.ovulation:
      return const PhaseStyle(
        background: kOvulation,
        textColor: Colors.white,
        label: 'Ovulasyon günü',
      );
    case DayPhase.none:
      return const PhaseStyle(
        background: Color(0xFFF1F1F1),
        textColor: Color(0xFF555555),
        label: 'Normal gün',
      );
  }
}
