import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark ? AppColors.bgGradientDark : AppColors.bgGradientLight,
        ),
      ),
      child: child,
    );
  }
}
