// =============================================
// providers/cycle_provider.dart
// Uygulama genelinde state yönetimi
// Değişiklikler otomatik olarak UI'a yansır
// =============================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cycle_model.dart';

class CycleProvider extends ChangeNotifier {
  DateTime _focusedMonth;
  DateTime? _selectedDay;
  DateTime _cycleStart;
  int _cycleLength;
  int _periodLength;

  CycleProvider()
      : _focusedMonth = DateTime(DateTime.now().year, DateTime.now().month),
        _cycleStart = DateTime(DateTime.now().year, DateTime.now().month - 1, 18),
        _cycleLength = 28,
        _periodLength = 5 {
    _loadPrefs();
  }

  // ---- Getter'lar ----
  DateTime get focusedMonth => _focusedMonth;
  DateTime? get selectedDay => _selectedDay;
  int get cycleLength => _cycleLength;
  int get periodLength => _periodLength;

  CycleModel get cycle => CycleModel(
        cycleStart: _cycleStart,
        cycleLength: _cycleLength,
        periodLength: _periodLength,
      );

  // ---- Ay navigasyonu ----
  void previousMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    notifyListeners();
  }

  // ---- Gün seçimi ----
  void selectDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  // ---- Regl başlat ----
  void startPeriod(DateTime date) {
    _cycleStart = date;
    _savePrefs();
    notifyListeners();
  }

  // ---- Döngü ayarları ----
  void updateCycleLength(int value) {
    _cycleLength = value;
    _savePrefs();
    notifyListeners();
  }

  void updatePeriodLength(int value) {
    _periodLength = value;
    _savePrefs();
    notifyListeners();
  }

  // ---- Faz sorgulama ----
  DayPhase phaseOf(DateTime date) => cycle.phaseOf(date);

  // ---- SharedPreferences ----
  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final startMs = prefs.getInt('cycleStart');
    if (startMs != null) {
      _cycleStart = DateTime.fromMillisecondsSinceEpoch(startMs);
    }
    _cycleLength = prefs.getInt('cycleLength') ?? 28;
    _periodLength = prefs.getInt('periodLength') ?? 5;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cycleStart', _cycleStart.millisecondsSinceEpoch);
    await prefs.setInt('cycleLength', _cycleLength);
    await prefs.setInt('periodLength', _periodLength);
  }
}
