// =============================================
// screens/auth/login_screen.dart
// Email + Password sign-in + Google Sign-In.
// After successful sign-in, AuthGate automatically routes forward.
// =============================================

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'auth_scaffold.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _signInEmail() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final auth = context.read<AuthProvider>().authService;
      await auth.signInWithEmail(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
      );
      // AuthGate will route automatically
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapError(e));
    } catch (e) {
      setState(() => _error = 'Beklenmeyen bir hata oluştu');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _signInGoogle() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final auth = context.read<AuthProvider>().authService;
      await auth.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapError(e));
    } catch (e) {
      setState(() => _error = 'Google girişi başarısız');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Geçersiz email adresi';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email veya şifre hatalı';
      case 'user-disabled':
        return 'Bu hesap devre dışı bırakılmış';
      case 'too-many-requests':
        return 'Çok fazla deneme. Lütfen daha sonra tekrar deneyin';
      default:
        return 'Giriş başarısız: ${e.code}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Hoş geldin',
      subtitle: 'Devam etmek için giriş yap',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              autofillHints: const [AutofillHints.password],
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
                if ((v ?? '').isEmpty) return 'Şifre gerekli';
                return null;
              },
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _loading
                    ? null
                    : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        ),
                child: const Text('Şifremi unuttum'),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: AppColors.danger, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _signInEmail,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('GİRİŞ YAP'),
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
              onPressed: _loading ? null : _signInGoogle,
              icon: const Icon(Icons.g_mobiledata, size: 28),
              label: const Text('Google ile devam et'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hesabın yok mu? '),
                TextButton(
                  onPressed: _loading
                      ? null
                      : () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          ),
                  child: const Text('Kayıt ol'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
