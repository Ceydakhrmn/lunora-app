// =============================================
// providers/cycle_provider.dart
// Uygulama genelinde state yönetimi
// =============================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cycle_model.dart';

enum AppMode { reglTakip, hamileTakip, hamilleKalma }

class CycleProvider extends ChangeNotifier {
  DateTime _focusedMonth;
  DateTime? _selectedDay;
  DateTime _cycleStart;
  int _cycleLength;
  int _periodLength;
  bool _isPeriodActive = false;
  AppMode _appMode = AppMode.reglTakip;
  bool _reminderPeriodStart = true;
  bool _reminderPeriodEnd = false;
  bool _reminderOvulation = false;
  bool _reminderFertile = false;
  final Map<String, String> _dayNotes = {};

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

  String _dateKey(DateTime d) => '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';

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

  // ---- Regl başlat / bitir ----
  void startPeriod(DateTime date) {
    _cycleStart = date;
    _isPeriodActive = true;
    _savePrefs();
    notifyListeners();
  }

  void endPeriod() {
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
  void updateReminderPeriodStart(bool value) {
    _reminderPeriodStart = value;
    _savePrefs();
    notifyListeners();
  }

  void updateReminderPeriodEnd(bool value) {
    _reminderPeriodEnd = value;
    _savePrefs();
    notifyListeners();
  }

  void updateReminderOvulation(bool value) {
    _reminderOvulation = value;
    _savePrefs();
    notifyListeners();
  }

  void updateReminderFertile(bool value) {
    _reminderFertile = value;
    _savePrefs();
    notifyListeners();
  }

  // ---- Günlük notlar ----
  void saveNote(DateTime day, String note) {
    final key = _dateKey(day);
    if (note.isEmpty) {
      _dayNotes.remove(key);
    } else {
      _dayNotes[key] = note;
    }
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
    _isPeriodActive = prefs.getBool('isPeriodActive') ?? false;
    _appMode = AppMode.values[prefs.getInt('appMode') ?? 0];
    _reminderPeriodStart = prefs.getBool('reminderPeriodStart') ?? true;
    _reminderPeriodEnd = prefs.getBool('reminderPeriodEnd') ?? false;
    _reminderOvulation = prefs.getBool('reminderOvulation') ?? false;
    _reminderFertile = prefs.getBool('reminderFertile') ?? false;
    final noteKeys = prefs.getStringList('noteKeys') ?? [];
    for (final key in noteKeys) {
      final val = prefs.getString('note_$key');
      if (val != null) _dayNotes[key] = val;
    }
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cycleStart', _cycleStart.millisecondsSinceEpoch);
    await prefs.setInt('cycleLength', _cycleLength);
    await prefs.setInt('periodLength', _periodLength);
    await prefs.setBool('isPeriodActive', _isPeriodActive);
    await prefs.setInt('appMode', _appMode.index);
    await prefs.setBool('reminderPeriodStart', _reminderPeriodStart);
    await prefs.setBool('reminderPeriodEnd', _reminderPeriodEnd);
    await prefs.setBool('reminderOvulation', _reminderOvulation);
    await prefs.setBool('reminderFertile', _reminderFertile);
    await prefs.setStringList('noteKeys', _dayNotes.keys.toList());
    for (final entry in _dayNotes.entries) {
      await prefs.setString('note_${entry.key}', entry.value);
    }
  }
}
