// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Lunora';

  @override
  String get appSubtitle => 'Döngünü takip et, paylaş ve bağlan';

  @override
  String get calendarTab => 'Takvim';

  @override
  String get exerciseTab => 'Egzersiz';

  @override
  String get socialTab => 'Sosyal';

  @override
  String get profileTab => 'Profil';

  @override
  String get loginTitle => 'Hoş geldin';

  @override
  String get loginSubtitle => 'Devam etmek için giriş yap';

  @override
  String get registerTitle => 'Hesap oluştur';

  @override
  String get registerSubtitle => 'Topluluğa katılmak için kayıt ol';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get confirmPasswordLabel => 'Şifre (tekrar)';

  @override
  String get usernameLabel => 'Kullanıcı adı';

  @override
  String get displayNameLabel => 'İsim (görünen ad)';

  @override
  String get loginButton => 'GİRİŞ YAP';

  @override
  String get registerButton => 'KAYIT OL';

  @override
  String get loginWithGoogle => 'Google ile devam et';

  @override
  String get forgotPassword => 'Şifremi unuttum';

  @override
  String get noAccountYet => 'Hesabın yok mu?';

  @override
  String get alreadyHaveAccount => 'Zaten hesabın var mı?';

  @override
  String get signUpLink => 'Kayıt ol';

  @override
  String get signInLink => 'Giriş yap';

  @override
  String get passwordsDontMatch => 'Şifreler eşleşmiyor';

  @override
  String get passwordTooShort => 'Şifre en az 6 karakter olmalı';

  @override
  String get emailInvalid => 'Geçerli bir email girin';

  @override
  String get emailRequired => 'Email gerekli';

  @override
  String get passwordRequired => 'Şifre gerekli';

  @override
  String get usernameTaken => 'Bu kullanıcı adı alınmış';

  @override
  String get usernameInvalid => 'Geçersiz kullanıcı adı';

  @override
  String get verifyEmailTitle => 'Email doğrulama';

  @override
  String get verifyEmailSubtitle => 'Kayıt tamamlandı, sadece bir adım kaldı';

  @override
  String get verifyEmailBody => 'Sana bir doğrulama linki gönderdik. Email kutunu kontrol et ve linke tıkla.';

  @override
  String get verifyEmailPolling => 'Doğrulama tamamlandığında otomatik olarak devam edilecek.';

  @override
  String get verifyEmailSent => 'Doğrulama e-postası gönderildi';

  @override
  String get verifiedButton => 'DOĞRULADIM';

  @override
  String get resendVerification => 'Maili tekrar gönder';

  @override
  String get forgotPasswordTitle => 'Şifremi unuttum';

  @override
  String get forgotPasswordSubtitle => 'Sana sıfırlama linki gönderelim';

  @override
  String get sendResetLink => 'SIFIRLAMA LİNKİ GÖNDER';

  @override
  String get resetLinkSent => 'Sıfırlama linki gönderildi';

  @override
  String get backToLogin => 'GİRİŞE DÖN';

  @override
  String get socialLatest => 'En Yeni';

  @override
  String get socialPopular => 'Popüler';

  @override
  String get newPost => 'Yeni Paylaşım';

  @override
  String get editPost => 'Postu Düzenle';

  @override
  String get postHint => 'Ne düşünüyorsun?';

  @override
  String get postAnonymously => 'Anonim paylaş';

  @override
  String get postAnonymouslyHint => 'Kullanıcı adın feed\'de gözükmez';

  @override
  String get share => 'PAYLAŞ';

  @override
  String get saveChanges => 'KAYDET';

  @override
  String get emptyPostError => 'Boş post gönderemezsin';

  @override
  String get profanityDetected => 'İçerik topluluk kurallarına uygun değil';

  @override
  String get noPostsYet => 'Henüz paylaşım yok';

  @override
  String get anonymousUser => 'Anonim';

  @override
  String get editedLabel => 'düzenlendi';

  @override
  String get deletePostTitle => 'Postu Sil';

  @override
  String get deletePostConfirm => 'Bu paylaşımı silmek istediğine emin misin?';

  @override
  String get commentsTitle => 'Yorumlar';

  @override
  String get writeComment => 'Yorum yaz...';

  @override
  String get reply => 'Yanıtla';

  @override
  String replyingTo(String username) {
    return 'Yanıt: $username';
  }

  @override
  String get noComments => 'Henüz yorum yok. İlk sen yaz!';

  @override
  String get deleteCommentTitle => 'Yorumu Sil';

  @override
  String get deleteCommentConfirm => 'Bu yorumu silmek istediğine emin misin?';

  @override
  String get reportPost => 'Şikayet Et';

  @override
  String get reportTitle => 'Şikayet Et';

  @override
  String get reportReasonHint => 'Lütfen sebebi seç';

  @override
  String get reportReasonSpam => 'Spam';

  @override
  String get reportReasonHarassment => 'Taciz';

  @override
  String get reportReasonInappropriate => 'Uygunsuz içerik';

  @override
  String get reportReasonHate => 'Nefret söylemi';

  @override
  String get reportReasonOther => 'Diğer';

  @override
  String get reportDescription => 'Açıklama (opsiyonel)';

  @override
  String get reportThanks => 'Şikayetin alındı, teşekkürler';

  @override
  String get reportAlreadyExists => 'Bunu zaten şikayet etmişsin';

  @override
  String get profileEdit => 'Profili Düzenle';

  @override
  String get profileSettings => 'Ayarlar';

  @override
  String get profileLogout => 'Çıkış Yap';

  @override
  String get confirmLogoutTitle => 'Çıkış Yap';

  @override
  String get confirmLogoutMsg => 'Oturumu kapatmak istediğinden emin misin?';

  @override
  String get cancelAction => 'Vazgeç';

  @override
  String get myPosts => 'Paylaşımlarım';

  @override
  String get statsPosts => 'Paylaşım';

  @override
  String get statsLikes => 'Beğeni';

  @override
  String get noMyPosts => 'Henüz paylaşımın yok';

  @override
  String get dangerZone => 'Tehlikeli Bölge';

  @override
  String get deleteAccount => 'HESABI SİL';

  @override
  String get deleteAccountConfirm => 'Bu işlem geri alınamaz. Tüm verilerin, paylaşımların ve yorumların silinecek. Emin misin?';

  @override
  String get changePassword => 'Şifreyi değiştir (opsiyonel)';

  @override
  String get currentPasswordLabel => 'Mevcut şifre';

  @override
  String get newPasswordLabel => 'Yeni şifre';

  @override
  String get changesSaved => 'Değişiklikler kaydedildi';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get generalSettings => 'Genel Ayarlar';

  @override
  String get appPurpose => 'Uygulama amacı';

  @override
  String get modePeriodTrack => 'Regl Takip';

  @override
  String get modePeriodTrackDesc => 'Adet döngünüzü takip edin';

  @override
  String get modePregnancy => 'Hamile Takip';

  @override
  String get modePregnancyDesc => 'Hamilelik sürecinizi takip edin';

  @override
  String get modeTryConceive => 'Hamile Kalma';

  @override
  String get modeTryConceiveDesc => 'Doğurganlık pencerelerinizi takip edin';

  @override
  String get notificationsSection => 'Bildirimler';

  @override
  String get notifCommentOnPost => 'Postuma yorum geldiğinde';

  @override
  String get notifCommentOnPostDesc => 'Paylaşımlarına yorum geldiğinde bildirim al';

  @override
  String get notifPeriodStart => 'Regl başladı';

  @override
  String get notifPeriodStartDesc => 'Regl günün geldiğinde hatırlat';

  @override
  String get notifPeriodEnd => 'Regl bitti';

  @override
  String get notifPeriodEndDesc => 'Regl bitiş günü hatırlat';

  @override
  String get notifExerciseReminder => 'Egzersiz hatırlatıcısı';

  @override
  String get notifExerciseReminderDesc => 'Haftada 2 kez egzersiz zamanı';

  @override
  String get themeSection => 'Tema';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSystem => 'Sistemi takip et';

  @override
  String get cycleSection => 'Döngü';

  @override
  String get cycleLengthLabel => 'Ortalama döngü uzunluğu';

  @override
  String get periodLengthLabel => 'Regl süresi';

  @override
  String get errorGeneric => 'Bir hata oluştu';

  @override
  String get tryAgain => 'Tekrar dene';
}
