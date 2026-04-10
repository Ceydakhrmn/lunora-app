// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Lunora';

  @override
  String get appSubtitle => 'Verfolge deinen Zyklus, teile und vernetze dich';

  @override
  String get calendarTab => 'Kalender';

  @override
  String get exerciseTab => 'Übung';

  @override
  String get socialTab => 'Sozial';

  @override
  String get profileTab => 'Profil';

  @override
  String get loginTitle => 'Willkommen';

  @override
  String get loginSubtitle => 'Melde dich an, um fortzufahren';

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get registerSubtitle => 'Registriere dich und tritt der Community bei';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get confirmPasswordLabel => 'Passwort (bestätigen)';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get displayNameLabel => 'Anzeigename';

  @override
  String get loginButton => 'ANMELDEN';

  @override
  String get registerButton => 'REGISTRIEREN';

  @override
  String get loginWithGoogle => 'Mit Google fortfahren';

  @override
  String get forgotPassword => 'Passwort vergessen';

  @override
  String get noAccountYet => 'Noch kein Konto?';

  @override
  String get alreadyHaveAccount => 'Schon ein Konto?';

  @override
  String get signUpLink => 'Registrieren';

  @override
  String get signInLink => 'Anmelden';

  @override
  String get passwordsDontMatch => 'Passwörter stimmen nicht überein';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get emailInvalid => 'Gib eine gültige Email ein';

  @override
  String get emailRequired => 'Email ist erforderlich';

  @override
  String get passwordRequired => 'Passwort ist erforderlich';

  @override
  String get usernameTaken => 'Dieser Benutzername ist vergeben';

  @override
  String get usernameInvalid => 'Ungültiger Benutzername';

  @override
  String get verifyEmailTitle => 'Email bestätigen';

  @override
  String get verifyEmailSubtitle => 'Fast fertig';

  @override
  String get verifyEmailBody => 'Wir haben dir einen Bestätigungslink gesendet. Bitte prüfe dein Postfach.';

  @override
  String get verifyEmailPolling => 'Du wirst automatisch fortgesetzt, sobald verifiziert.';

  @override
  String get verifyEmailSent => 'Bestätigungs-Email gesendet';

  @override
  String get verifiedButton => 'ICH HABE VERIFIZIERT';

  @override
  String get resendVerification => 'Email erneut senden';

  @override
  String get forgotPasswordTitle => 'Passwort vergessen';

  @override
  String get forgotPasswordSubtitle => 'Wir senden dir einen Reset-Link';

  @override
  String get sendResetLink => 'RESET-LINK SENDEN';

  @override
  String get resetLinkSent => 'Link gesendet';

  @override
  String get backToLogin => 'ZURÜCK ZUR ANMELDUNG';

  @override
  String get socialLatest => 'Neueste';

  @override
  String get socialPopular => 'Beliebt';

  @override
  String get newPost => 'Neuer Beitrag';

  @override
  String get editPost => 'Beitrag bearbeiten';

  @override
  String get postHint => 'Was denkst du?';

  @override
  String get postAnonymously => 'Anonym posten';

  @override
  String get postAnonymouslyHint => 'Dein Name erscheint nicht im Feed';

  @override
  String get share => 'TEILEN';

  @override
  String get saveChanges => 'SPEICHERN';

  @override
  String get emptyPostError => 'Leere Beiträge sind nicht erlaubt';

  @override
  String get profanityDetected => 'Inhalt verstößt gegen die Richtlinien';

  @override
  String get noPostsYet => 'Noch keine Beiträge';

  @override
  String get anonymousUser => 'Anonym';

  @override
  String get editedLabel => 'bearbeitet';

  @override
  String get deletePostTitle => 'Beitrag löschen';

  @override
  String get deletePostConfirm => 'Diesen Beitrag wirklich löschen?';

  @override
  String get commentsTitle => 'Kommentare';

  @override
  String get writeComment => 'Kommentar schreiben...';

  @override
  String get reply => 'Antworten';

  @override
  String replyingTo(String username) {
    return 'Antwort an $username';
  }

  @override
  String get noComments => 'Noch keine Kommentare. Sei der Erste!';

  @override
  String get deleteCommentTitle => 'Kommentar löschen';

  @override
  String get deleteCommentConfirm => 'Diesen Kommentar wirklich löschen?';

  @override
  String get reportPost => 'Melden';

  @override
  String get reportTitle => 'Melden';

  @override
  String get reportReasonHint => 'Wähle einen Grund';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Belästigung';

  @override
  String get reportReasonInappropriate => 'Unangemessen';

  @override
  String get reportReasonHate => 'Hassrede';

  @override
  String get reportReasonOther => 'Sonstiges';

  @override
  String get reportDescription => 'Beschreibung (optional)';

  @override
  String get reportThanks => 'Meldung erhalten, danke';

  @override
  String get reportAlreadyExists => 'Du hast das bereits gemeldet';

  @override
  String get profileEdit => 'Profil bearbeiten';

  @override
  String get profileSettings => 'Einstellungen';

  @override
  String get profileLogout => 'Abmelden';

  @override
  String get confirmLogoutTitle => 'Abmelden';

  @override
  String get confirmLogoutMsg => 'Möchtest du dich wirklich abmelden?';

  @override
  String get cancelAction => 'Abbrechen';

  @override
  String get myPosts => 'Meine Beiträge';

  @override
  String get statsPosts => 'Beiträge';

  @override
  String get statsLikes => 'Likes';

  @override
  String get noMyPosts => 'Du hast noch keine Beiträge';

  @override
  String get dangerZone => 'Gefahrenzone';

  @override
  String get deleteAccount => 'KONTO LÖSCHEN';

  @override
  String get deleteAccountConfirm => 'Dies kann nicht rückgängig gemacht werden. Alle deine Daten werden gelöscht. Fortfahren?';

  @override
  String get changePassword => 'Passwort ändern (optional)';

  @override
  String get currentPasswordLabel => 'Aktuelles Passwort';

  @override
  String get newPasswordLabel => 'Neues Passwort';

  @override
  String get changesSaved => 'Änderungen gespeichert';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get generalSettings => 'Allgemein';

  @override
  String get appPurpose => 'App-Zweck';

  @override
  String get modePeriodTrack => 'Zyklus-Tracking';

  @override
  String get modePeriodTrackDesc => 'Verfolge deinen Menstruationszyklus';

  @override
  String get modePregnancy => 'Schwangerschaft';

  @override
  String get modePregnancyDesc => 'Verfolge deine Schwangerschaft';

  @override
  String get modeTryConceive => 'Kinderwunsch';

  @override
  String get modeTryConceiveDesc => 'Fruchtbare Tage verfolgen';

  @override
  String get notificationsSection => 'Benachrichtigungen';

  @override
  String get notifCommentOnPost => 'Kommentar zu meinem Beitrag';

  @override
  String get notifCommentOnPostDesc => 'Benachrichtigen, wenn jemand kommentiert';

  @override
  String get notifPeriodStart => 'Periode begonnen';

  @override
  String get notifPeriodStartDesc => 'Erinnere mich, wenn meine Periode fällig ist';

  @override
  String get notifPeriodEnd => 'Periode beendet';

  @override
  String get notifPeriodEndDesc => 'Erinnere mich am Ende';

  @override
  String get notifExerciseReminder => 'Trainingserinnerung';

  @override
  String get notifExerciseReminderDesc => 'Zweimal pro Woche';

  @override
  String get themeSection => 'Design';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';

  @override
  String get cycleSection => 'Zyklus';

  @override
  String get cycleLengthLabel => 'Durchschnittliche Zykluslänge';

  @override
  String get periodLengthLabel => 'Periodenlänge';

  @override
  String get errorGeneric => 'Etwas ist schief gelaufen';

  @override
  String get tryAgain => 'Erneut versuchen';
}
