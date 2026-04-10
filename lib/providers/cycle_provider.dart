// =============================================
// providers/cycle_provider.dart
// =============================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cycle_model.dart';

enum AppMode { reglTakip, hamileTakip, hamilleKalma }

// Tek bir döngü kaydı
class CycleRecord {
  final DateTime start;
  final int periodDays;  // gerçek regl süresi
  final int cycleDays;   // o döngünün uzunluğu

  const CycleRecord({
    required this.start,
    required this.periodDays,
    required this.cycleDays,
  });
}

class CycleProvider extends ChangeNotifier {
  DateTime _focusedMonth;
  DateTime? _selectedDay;
  DateTime _cycleStart;
  int _cycleLength;
  int _periodLength;
  bool _isPeriodActive = false;
  DateTime? _periodActualStart; // kullanıcının gerçekten başlattığı gün
  DateTime? _periodEndDate;     // regl bitiş tarihi
  AppMode _appMode = AppMode.reglTakip;
  bool _reminderPeriodStart = true;
  bool _reminderPeriodEnd = false;
  bool _reminderOvulation = false;
  bool _reminderFertile = false;
  final Map<String, String> _dayNotes = {};

  // Geçmiş döngü kayıtları (en eski → en yeni)
  final List<CycleRecord> _cycleHistory = [];

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
  bool get isPeriodActive => _isPeriodActive;
  AppMode get appMode => _appMode;
  bool get reminderPeriodStart => _reminderPeriodStart;
  bool get reminderPeriodEnd => _reminderPeriodEnd;
  bool get reminderOvulation => _reminderOvulation;
  bool get reminderFertile => _reminderFertile;
  String noteForDay(DateTime day) => _dayNotes[_dateKey(day)] ?? '';
  List<CycleRecord> get cycleHistory => List.unmodifiable(_cycleHistory);

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

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
    _periodActualStart = date; // gerçek başlangıç (kullanıcının seçtiği/bastığı gün)
    _cycleStart = date;        // döngü başlangıcını da güncelle
    _periodEndDate = null;
    _isPeriodActive = true;
    _savePrefs();
    notifyListeners();
  }

  // ---- Regl bitir: gerçek süreyi kaydet ----
  void endPeriod() {
    final now = DateTime.now();
    _periodEndDate = now;
    final startForCalc = _periodActualStart ?? _cycleStart;
    final actualDays = now.difference(startForCalc).inDays + 1;
    final newPeriodLen = actualDays.clamp(1, 15);
    _periodLength = ((_periodLength + newPeriodLen) / 2).round();

    _cycleHistory.add(CycleRecord(
      start: _cycleStart,
      periodDays: newPeriodLen,
      cycleDays: _cycleLength,
    ));
    if (_cycleHistory.length > 12) _cycleHistory.removeAt(0);

    _isPeriodActive = false;
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

  // ---- Uygulama modu ----
  void updateAppMode(AppMode mode) {
    _appMode = mode;
    _savePrefs();
    notifyListeners();
  }

  // ---- Hatırlatıcılar ----
  void updateReminderPeriodStart(bool v) { _reminderPeriodStart = v; _savePrefs(); notifyListeners(); }
  void updateReminderPeriodEnd(bool v)   { _reminderPeriodEnd   = v; _savePrefs(); notifyListeners(); }
  void updateReminderOvulation(bool v)   { _reminderOvulation   = v; _savePrefs(); notifyListeners(); }
  void updateReminderFertile(bool v)     { _reminderFertile     = v; _savePrefs(); notifyListeners(); }

  // ---- Günlük notlar ----
  void saveNote(DateTime day, String note) {
    final key = _dateKey(day);
    if (note.isEmpty) { _dayNotes.remove(key); } else { _dayNotes[key] = note; }
    _savePrefs();
    notifyListeners();
  }

  // ---- Faz sorgulama ----
  DayPhase phaseOf(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);

    // Gerçek regl aralığını kontrol et
    final actualStart = _periodActualStart;
    if (actualStart != null) {
      final start = DateTime(actualStart.year, actualStart.month, actualStart.day);
      final rangeEnd = _isPeriodActive
          ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          : (_periodEndDate != null
              ? DateTime(_periodEndDate!.year, _periodEndDate!.month, _periodEndDate!.day)
              : null);

      if (rangeEnd != null && !d.isBefore(start) && !d.isAfter(rangeEnd)) {
        final dayNum = d.difference(start).inDays + 1;
        if (dayNum <= 2) return DayPhase.periodPeak;
        if (dayNum <= 3) return DayPhase.periodMid;
        return DayPhase.periodLight;
      }
    }

    return cycle.phaseOf(date);
  }

  // ---- İstatistik yardımcıları ----
  // Son N döngünün uzunlukları (grafik için)
  List<int> lastCycleLengths({int n = 6}) {
    final records = _cycleHistory.reversed.take(n).toList().reversed.toList();
    if (records.isEmpty) {
      // Kayıt yoksa sabit tahmin döndür
      return List.filled(n, _cycleLength);
    }
    return records.map((r) => r.cycleDays).toList();
  }

  // Son N döngünün regl süreleri
  List<int> lastPeriodLengths({int n = 6}) {
    final records = _cycleHistory.reversed.take(n).toList().reversed.toList();
    if (records.isEmpty) return List.filled(n, _periodLength);
    return records.map((r) => r.periodDays).toList();
  }

  // ---- SharedPreferences ----
  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final startMs = prefs.getInt('cycleStart');
    if (startMs != null) _cycleStart = DateTime.fromMillisecondsSinceEpoch(startMs);
    _cycleLength       = prefs.getInt('cycleLength') ?? 28;
    _periodLength      = prefs.getInt('periodLength') ?? 5;
    _isPeriodActive    = prefs.getBool('isPeriodActive') ?? false;
    final endMs = prefs.getInt('periodEndDate');
    if (endMs != null) _periodEndDate = DateTime.fromMillisecondsSinceEpoch(endMs);
    final actualStartMs = prefs.getInt('periodActualStart');
    if (actualStartMs != null) _periodActualStart = DateTime.fromMillisecondsSinceEpoch(actualStartMs);
    _appMode           = AppMode.values[prefs.getInt('appMode') ?? 0];
    _reminderPeriodStart = prefs.getBool('reminderPeriodStart') ?? true;
    _reminderPeriodEnd   = prefs.getBool('reminderPeriodEnd') ?? false;
    _reminderOvulation   = prefs.getBool('reminderOvulation') ?? false;
    _reminderFertile     = prefs.getBool('reminderFertile') ?? false;

    // Notlar
    final noteKeys = prefs.getStringList('noteKeys') ?? [];
    for (final key in noteKeys) {
      final val = prefs.getString('note_$key');
      if (val != null) _dayNotes[key] = val;
    }

    // Döngü geçmişi
    final histCount = prefs.getInt('histCount') ?? 0;
    for (var i = 0; i < histCount; i++) {
      final ms  = prefs.getInt('hist_start_$i');
      final pd  = prefs.getInt('hist_period_$i');
      final cl  = prefs.getInt('hist_cycle_$i');
      if (ms != null && pd != null && cl != null) {
        _cycleHistory.add(CycleRecord(
          start: DateTime.fromMillisecondsSinceEpoch(ms),
          periodDays: pd,
          cycleDays: cl,
        ));
      }
    }

    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cycleStart', _cycleStart.millisecondsSinceEpoch);
    await prefs.setInt('cycleLength', _cycleLength);
    await prefs.setInt('periodLength', _periodLength);
    await prefs.setBool('isPeriodActive', _isPeriodActive);
    if (_periodEndDate != null) {
      await prefs.setInt('periodEndDate', _periodEndDate!.millisecondsSinceEpoch);
    }
    if (_periodActualStart != null) {
      await prefs.setInt('periodActualStart', _periodActualStart!.millisecondsSinceEpoch);
    }
    await prefs.setInt('appMode', _appMode.index);
    await prefs.setBool('reminderPeriodStart', _reminderPeriodStart);
    await prefs.setBool('reminderPeriodEnd', _reminderPeriodEnd);
    await prefs.setBool('reminderOvulation', _reminderOvulation);
    await prefs.setBool('reminderFertile', _reminderFertile);
    await prefs.setStringList('noteKeys', _dayNotes.keys.toList());
    for (final entry in _dayNotes.entries) {
      await prefs.setString('note_${entry.key}', entry.value);
    }
    // Döngü geçmişi
    await prefs.setInt('histCount', _cycleHistory.length);
    for (var i = 0; i < _cycleHistory.length; i++) {
      await prefs.setInt('hist_start_$i', _cycleHistory[i].start.millisecondsSinceEpoch);
      await prefs.setInt('hist_period_$i', _cycleHistory[i].periodDays);
      await prefs.setInt('hist_cycle_$i', _cycleHistory[i].cycleDays);
    }
  }
}
