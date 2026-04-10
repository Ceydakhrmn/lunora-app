// =============================================
// models/notification_prefs.dart
// =============================================

class NotificationPrefs {
  final bool commentOnPost;
  final bool periodStart;
  final bool periodEnd;
  final bool exerciseReminder;

  const NotificationPrefs({
    this.commentOnPost = true,
    this.periodStart = true,
    this.periodEnd = true,
    this.exerciseReminder = true,
  });

  NotificationPrefs copyWith({
    bool? commentOnPost,
    bool? periodStart,
    bool? periodEnd,
    bool? exerciseReminder,
  }) {
    return NotificationPrefs(
      commentOnPost: commentOnPost ?? this.commentOnPost,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      exerciseReminder: exerciseReminder ?? this.exerciseReminder,
    );
  }

  Map<String, dynamic> toMap() => {
        'commentOnPost': commentOnPost,
        'periodStart': periodStart,
        'periodEnd': periodEnd,
        'exerciseReminder': exerciseReminder,
      };

  factory NotificationPrefs.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const NotificationPrefs();
    return NotificationPrefs(
      commentOnPost: map['commentOnPost'] as bool? ?? true,
      periodStart: map['periodStart'] as bool? ?? true,
      periodEnd: map['periodEnd'] as bool? ?? true,
      exerciseReminder: map['exerciseReminder'] as bool? ?? true,
    );
  }
}
