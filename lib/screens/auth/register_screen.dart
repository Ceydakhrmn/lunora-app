// =============================================
// screens/auth/register_screen.dart
// Email + password registration with username uniqueness + display name.
// After successful registration: creates Firebase Auth user, reserves
// username + creates Firestore profile atomically, sends verification
// email. AuthGate routes to VerifyEmailScreen automatically.
// =============================================

import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../services/user_service.dart';
import 'auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _displayNameCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _usernameCtrl.dispose();
    _displayNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final auth = context.read<AuthProvider>();

    try {
      // Cheap pre-check (the transaction below is the real claim).
      final available = await auth.userService
          .isUsernameAvailable(_usernameCtrl.text);
      if (!available) {
        setState(() => _error = 'Bu kullanıcı adı alınmış');
        return;
      }

      final cred = await auth.authService.signUpWithEmail(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
      );

      final uid = cred.user!.uid;

      try {
        await auth.userService.createUserProfile(
          uid: uid,
          email: _emailCtrl.text.trim(),
          username: _usernameCtrl.text,
          displayName: _displayNameCtrl.text,
        );
      } on UsernameTaken {
        // Rollback the freshly-created auth user so the email can be reused.
        try {
          await cred.user?.delete();
        } catch (_) {}
        setState(() => _error = 'Bu kullanıcı adı alınmış');
        return;
      }

      await auth.authService.updateDisplayName(_displayNameCtrl.text.trim());
      await auth.authService.sendEmailVerification();
      // AuthGate routes to VerifyEmailScreen automatically.
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapError(e));
    } catch (e) {
      setState(() => _error = 'Kayıt başarısız: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _signUpGoogle() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await context.read<AuthProvider>().authService.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapError(e));
    } catch (e) {
      setState(() => _error = 'Google kaydı başarısız');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Bu email zaten kayıtlı';
      case 'invalid-email':
        return 'Geçersiz email adresi';
      case 'weak-password':
        return 'Şifre çok zayıf (en az 6 karakter)';
      case 'operation-not-allowed':
        return 'Email/şifre girişi etkin değil';
      default:
        return 'Kayıt başarısız: ${e.code}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      title: 'Hesap oluştur',
      subtitle: 'Topluluğa katılmak için kayıt ol',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _displayNameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'İsim (görünen ad)',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              validator: (v) {
                final s = (v ?? '').trim();
                if (s.length < 2) return 'En az 2 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _usernameCtrl,
              decoration: const InputDecoration(
                labelText: 'Kullanıcı adı',
                prefixIcon: Icon(Icons.alternate_email),
                helperText: '3-20 karakter, küçük harf/rakam/._',
              ),
              validator: (v) {
                final s = (v ?? '').trim();
                if (s.isEmpty) return 'Kullanıcı adı gerekli';
                if (!UserService.isValidUsername(s)) {
                  return 'Geçersiz kullanıcı adı';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (v) {
                final s = (v ?? '').trim();
                if (s.isEmpty) return 'Email gerekli';
                if (!s.contains('@') || !s.contains('.')) {
                  return 'Geçerli bir email girin';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Şifre',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              validator: (v) {
                final s = v ?? '';
                if (s.length < 6) return 'En az 6 karakter';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmCtrl,
              obscureText: _obscure,
              decoration: const InputDecoration(
                labelText: 'Şifre (tekrar)',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: (v) {
                if (v != _passwordCtrl.text) return 'Şifreler eşleşmiyor';
                return null;
              },
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                style: const TextStyle(color: AppColors.danger, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _register,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('KAYIT OL'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'veya',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _loading ? null : _signUpGoogle,
              icon: const Icon(Icons.g_mobiledata, size: 28),
              label: const Text('Google ile devam et'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Zaten hesabın var mı? '),
                TextButton(
                  onPressed:
                      _loading ? null : () => Navigator.of(context).pop(),
                  child: const Text('Giriş yap'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
