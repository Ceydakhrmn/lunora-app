// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Lunora';

  @override
  String get appSubtitle => 'Suis ton cycle, partage et connecte-toi';

  @override
  String get calendarTab => 'Calendrier';

  @override
  String get exerciseTab => 'Exercice';

  @override
  String get socialTab => 'Social';

  @override
  String get profileTab => 'Profil';

  @override
  String get loginTitle => 'Bienvenue';

  @override
  String get loginSubtitle => 'Connecte-toi pour continuer';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerSubtitle => 'Inscris-toi pour rejoindre la communauté';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get confirmPasswordLabel => 'Mot de passe (confirmer)';

  @override
  String get usernameLabel => 'Nom d\'utilisateur';

  @override
  String get displayNameLabel => 'Nom affiché';

  @override
  String get loginButton => 'CONNEXION';

  @override
  String get registerButton => 'S\'INSCRIRE';

  @override
  String get loginWithGoogle => 'Continuer avec Google';

  @override
  String get forgotPassword => 'Mot de passe oublié';

  @override
  String get noAccountYet => 'Pas de compte ?';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ?';

  @override
  String get signUpLink => 'S\'inscrire';

  @override
  String get signInLink => 'Se connecter';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get emailInvalid => 'Entre un email valide';

  @override
  String get emailRequired => 'Email requis';

  @override
  String get passwordRequired => 'Mot de passe requis';

  @override
  String get usernameTaken => 'Ce nom est déjà pris';

  @override
  String get usernameInvalid => 'Nom invalide';

  @override
  String get verifyEmailTitle => 'Vérifie ton email';

  @override
  String get verifyEmailSubtitle => 'Presque terminé';

  @override
  String get verifyEmailBody =>
      'Nous avons envoyé un lien de vérification à ton email.';

  @override
  String get verifyEmailPolling =>
      'Tu continueras automatiquement une fois vérifié.';

  @override
  String get verifyEmailSent => 'Email de vérification envoyé';

  @override
  String get verifiedButton => 'J\'AI VÉRIFIÉ';

  @override
  String get resendVerification => 'Renvoyer l\'email';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get forgotPasswordSubtitle =>
      'On t\'envoie un lien de réinitialisation';

  @override
  String get sendResetLink => 'ENVOYER LE LIEN';

  @override
  String get resetLinkSent => 'Lien envoyé';

  @override
  String get backToLogin => 'RETOUR À LA CONNEXION';

  @override
  String get socialLatest => 'Récents';

  @override
  String get socialPopular => 'Populaires';

  @override
  String get newPost => 'Nouveau post';

  @override
  String get editPost => 'Modifier';

  @override
  String get postHint => 'Qu\'as-tu en tête ?';

  @override
  String get postAnonymously => 'Publier anonymement';

  @override
  String get postAnonymouslyHint => 'Ton nom n\'apparaîtra pas';

  @override
  String get share => 'PUBLIER';

  @override
  String get saveChanges => 'ENREGISTRER';

  @override
  String get emptyPostError => 'Le post ne peut pas être vide';

  @override
  String get profanityDetected => 'Contenu contraire aux règles';

  @override
  String get noPostsYet => 'Aucun post pour le moment';

  @override
  String get anonymousUser => 'Anonyme';

  @override
  String get editedLabel => 'modifié';

  @override
  String get deletePostTitle => 'Supprimer le post';

  @override
  String get deletePostConfirm => 'Es-tu sûr de vouloir supprimer ce post ?';

  @override
  String get commentsTitle => 'Commentaires';

  @override
  String get writeComment => 'Écris un commentaire...';

  @override
  String get reply => 'Répondre';

  @override
  String replyingTo(String username) {
    return 'Réponse à $username';
  }

  @override
  String get noComments => 'Aucun commentaire. Sois le premier !';

  @override
  String get deleteCommentTitle => 'Supprimer le commentaire';

  @override
  String get deleteCommentConfirm => 'Supprimer ce commentaire ?';

  @override
  String get reportPost => 'Signaler';

  @override
  String get reportTitle => 'Signaler';

  @override
  String get reportReasonHint => 'Choisis un motif';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Harcèlement';

  @override
  String get reportReasonInappropriate => 'Inapproprié';

  @override
  String get reportReasonHate => 'Discours haineux';

  @override
  String get reportReasonOther => 'Autre';

  @override
  String get reportDescription => 'Description (optionnel)';

  @override
  String get reportThanks => 'Signalement reçu, merci';

  @override
  String get reportAlreadyExists => 'Tu l\'as déjà signalé';

  @override
  String get profileEdit => 'Modifier le profil';

  @override
  String get profileSettings => 'Paramètres';

  @override
  String get profileLogout => 'Déconnexion';

  @override
  String get confirmLogoutTitle => 'Déconnexion';

  @override
  String get confirmLogoutMsg => 'Veux-tu vraiment te déconnecter ?';

  @override
  String get cancelAction => 'Annuler';

  @override
  String get myPosts => 'Mes posts';

  @override
  String get statsPosts => 'Posts';

  @override
  String get statsLikes => 'Likes';

  @override
  String get noMyPosts => 'Tu n\'as pas encore de posts';

  @override
  String get dangerZone => 'Zone dangereuse';

  @override
  String get deleteAccount => 'SUPPRIMER LE COMPTE';

  @override
  String get deleteAccountConfirm =>
      'Cette action est irréversible. Toutes tes données seront supprimées. Continuer ?';

  @override
  String get changePassword => 'Changer de mot de passe (optionnel)';

  @override
  String get currentPasswordLabel => 'Mot de passe actuel';

  @override
  String get newPasswordLabel => 'Nouveau mot de passe';

  @override
  String get changesSaved => 'Modifications enregistrées';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get generalSettings => 'Général';

  @override
  String get appPurpose => 'Objectif de l\'app';

  @override
  String get modePeriodTrack => 'Suivi du cycle';

  @override
  String get modePeriodTrackDesc => 'Suis ton cycle menstruel';

  @override
  String get modePregnancy => 'Grossesse';

  @override
  String get modePregnancyDesc => 'Suis ta grossesse';

  @override
  String get modeTryConceive => 'Concevoir';

  @override
  String get modeTryConceiveDesc => 'Suis ta fenêtre de fertilité';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get notifCommentOnPost => 'Commentaire sur mon post';

  @override
  String get notifCommentOnPostDesc => 'Me notifier quand quelqu\'un commente';

  @override
  String get notifPeriodStart => 'Début des règles';

  @override
  String get notifPeriodStartDesc => 'Me rappeler le jour de mes règles';

  @override
  String get notifPeriodEnd => 'Fin des règles';

  @override
  String get notifPeriodEndDesc => 'Me rappeler la fin';

  @override
  String get notifExerciseReminder => 'Rappel d\'exercice';

  @override
  String get notifExerciseReminderDesc => 'Deux fois par semaine';

  @override
  String get themeSection => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get cycleSection => 'Cycle';

  @override
  String get cycleLengthLabel => 'Durée moyenne du cycle';

  @override
  String get periodLengthLabel => 'Durée des règles';

  @override
  String get errorGeneric => 'Une erreur est survenue';

  @override
  String get tryAgain => 'Réessayer';
}
