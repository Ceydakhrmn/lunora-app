// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lunora';

  @override
  String get appSubtitle => 'Track your cycle, share and connect';

  @override
  String get calendarTab => 'Calendar';

  @override
  String get exerciseTab => 'Exercise';

  @override
  String get socialTab => 'Social';

  @override
  String get profileTab => 'Profile';

  @override
  String get loginTitle => 'Welcome';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerSubtitle => 'Sign up to join the community';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Password (confirm)';

  @override
  String get usernameLabel => 'Username';

  @override
  String get displayNameLabel => 'Display name';

  @override
  String get loginButton => 'SIGN IN';

  @override
  String get registerButton => 'SIGN UP';

  @override
  String get loginWithGoogle => 'Continue with Google';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get noAccountYet => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signUpLink => 'Sign up';

  @override
  String get signInLink => 'Sign in';

  @override
  String get passwordsDontMatch => 'Passwords do not match';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get usernameTaken => 'That username is taken';

  @override
  String get usernameInvalid => 'Invalid username';

  @override
  String get verifyEmailTitle => 'Verify email';

  @override
  String get verifyEmailSubtitle => 'Almost there';

  @override
  String get verifyEmailBody => 'We sent a verification link to your email. Please check your inbox.';

  @override
  String get verifyEmailPolling => 'You\'ll continue automatically once verified.';

  @override
  String get verifyEmailSent => 'Verification email sent';

  @override
  String get verifiedButton => 'I\'VE VERIFIED';

  @override
  String get resendVerification => 'Resend email';

  @override
  String get forgotPasswordTitle => 'Forgot password';

  @override
  String get forgotPasswordSubtitle => 'We\'ll send you a reset link';

  @override
  String get sendResetLink => 'SEND RESET LINK';

  @override
  String get resetLinkSent => 'Reset link sent';

  @override
  String get backToLogin => 'BACK TO SIGN IN';

  @override
  String get socialLatest => 'Latest';

  @override
  String get socialPopular => 'Popular';

  @override
  String get newPost => 'New Post';

  @override
  String get editPost => 'Edit Post';

  @override
  String get postHint => 'What\'s on your mind?';

  @override
  String get postAnonymously => 'Post anonymously';

  @override
  String get postAnonymouslyHint => 'Your username won\'t appear in the feed';

  @override
  String get share => 'SHARE';

  @override
  String get saveChanges => 'SAVE';

  @override
  String get emptyPostError => 'You can\'t post empty content';

  @override
  String get profanityDetected => 'Content violates community guidelines';

  @override
  String get noPostsYet => 'No posts yet';

  @override
  String get anonymousUser => 'Anonymous';

  @override
  String get editedLabel => 'edited';

  @override
  String get deletePostTitle => 'Delete Post';

  @override
  String get deletePostConfirm => 'Are you sure you want to delete this post?';

  @override
  String get commentsTitle => 'Comments';

  @override
  String get writeComment => 'Write a comment...';

  @override
  String get reply => 'Reply';

  @override
  String replyingTo(String username) {
    return 'Replying to $username';
  }

  @override
  String get noComments => 'No comments yet. Be the first!';

  @override
  String get deleteCommentTitle => 'Delete Comment';

  @override
  String get deleteCommentConfirm => 'Are you sure you want to delete this comment?';

  @override
  String get reportPost => 'Report';

  @override
  String get reportTitle => 'Report';

  @override
  String get reportReasonHint => 'Please select a reason';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Harassment';

  @override
  String get reportReasonInappropriate => 'Inappropriate';

  @override
  String get reportReasonHate => 'Hate speech';

  @override
  String get reportReasonOther => 'Other';

  @override
  String get reportDescription => 'Description (optional)';

  @override
  String get reportThanks => 'Report received, thank you';

  @override
  String get reportAlreadyExists => 'You already reported this';

  @override
  String get profileEdit => 'Edit Profile';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get confirmLogoutTitle => 'Log Out';

  @override
  String get confirmLogoutMsg => 'Are you sure you want to sign out?';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get myPosts => 'My Posts';

  @override
  String get statsPosts => 'Posts';

  @override
  String get statsLikes => 'Likes';

  @override
  String get noMyPosts => 'You have no posts yet';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get deleteAccount => 'DELETE ACCOUNT';

  @override
  String get deleteAccountConfirm => 'This cannot be undone. All your data, posts and comments will be deleted. Continue?';

  @override
  String get changePassword => 'Change password (optional)';

  @override
  String get currentPasswordLabel => 'Current password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get changesSaved => 'Changes saved';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get generalSettings => 'General';

  @override
  String get appPurpose => 'App purpose';

  @override
  String get modePeriodTrack => 'Period Tracking';

  @override
  String get modePeriodTrackDesc => 'Track your menstrual cycle';

  @override
  String get modePregnancy => 'Pregnancy';

  @override
  String get modePregnancyDesc => 'Track your pregnancy';

  @override
  String get modeTryConceive => 'Trying to Conceive';

  @override
  String get modeTryConceiveDesc => 'Track fertility windows';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get notifCommentOnPost => 'Comment on my post';

  @override
  String get notifCommentOnPostDesc => 'Notify me when someone comments on my post';

  @override
  String get notifPeriodStart => 'Period started';

  @override
  String get notifPeriodStartDesc => 'Remind me when my period is due';

  @override
  String get notifPeriodEnd => 'Period ended';

  @override
  String get notifPeriodEndDesc => 'Remind me when my period ends';

  @override
  String get notifExerciseReminder => 'Exercise reminder';

  @override
  String get notifExerciseReminderDesc => 'Twice a week';

  @override
  String get themeSection => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'Follow system';

  @override
  String get cycleSection => 'Cycle';

  @override
  String get cycleLengthLabel => 'Average cycle length';

  @override
  String get periodLengthLabel => 'Period length';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get tryAgain => 'Try again';
}
