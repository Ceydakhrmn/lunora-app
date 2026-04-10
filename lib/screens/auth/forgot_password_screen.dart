// =============================================
// screens/auth/forgot_password_screen.dart
// Send password reset email via Firebase Auth.
// =============================================

import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'auth_scaffold.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _sent = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await context
          .read<AuthProvider>()
          .authService
          .sendPasswordResetEmail(_emailCtrl.text);
      if (!mounted) return;
      setState(() => _sent = true);
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapError(e));
    } catch (e) {
      setState(() => _error = 'Beklenmeyen hata');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Geçersiz email adresi';
      case 'user-not-found':
        return 'Bu email ile kayıtlı hesap bulunamadı';
      default:
        return 'Gönderim başarısız: ${e.code}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      title: 'Şifremi unuttum',
      subtitle: _sent
          ? 'Email kutunu kontrol et'
          : 'Sana sıfırlama linki gönderelim',
      child: _sent
          ? Column(
              children: [
                const Icon(Icons.mark_email_read_outlined,
                    size: 64, color: AppColors.primary),
                const SizedBox(height: 12),
                Text(
                  '${_emailCtrl.text.trim()} adresine sıfırlama linki gönderildi.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('GİRİŞE DÖN'),
                ),
              ],
            )
          : Form(
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
                      if (!s.contains('@')) return 'Geçerli bir email girin';
                      return null;
                    },
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: const TextStyle(
                          color: AppColors.danger, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loading ? null : _send,
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('SIFIRLAMA LİNKİ GÖNDER'),
                  ),
                ],
              ),
            ),
    );
  }
}
