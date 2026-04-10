// =============================================
// screens/auth/auth_scaffold.dart
// Shared gradient background + brand header for auth screens.
// =============================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showBack = false,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
                    Color(0xFF1A132A),
                    Color(0xFF121017),
                    Color(0xFF0F0C18),
                  ]
                : const [
                    Color(0xFFE5D1FA),
                    Color(0xFFFDEFF9),
                    Color(0xFFCAE9FF),
                  ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              if (showBack)
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: isDark ? Colors.white70 : Colors.black54),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Brand
                      Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(bottom: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.spa,
                            size: 40, color: AppColors.primary),
                      ),
                      Text(
                        'Lunora',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 34,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 8,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF5D5461),
                        ),
                      ),
                      if (title != null) ...[
                        const SizedBox(height: 24),
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : AppColors.textPrimaryLight,
                          ),
                        ),
                      ],
                      if (subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          subtitle!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? Colors.white70
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      child,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
