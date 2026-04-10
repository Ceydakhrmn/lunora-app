// =============================================
// widgets/day_cell.dart
// Takvimdeki tek bir gün kutusu
// =============================================

import 'package:flutter/material.dart';

class DayCell extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOtherMonth;
  final bool isToday;
  final bool isSelected;
  final VoidCallback? onTap;

  const DayCell({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.isOtherMonth = false,
    this.isToday = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFFF1F1F1);
    final fg = textColor ?? const Color(0xFF555555);

    return GestureDetector(
      onTap: isOtherMonth ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Diğer aylara ait günler renksiz ve şeffaf
          color: isOtherMonth ? Colors.transparent : bg,
          // Bugün için dış çizgi (outline)
          border: isToday && !isSelected
              ? Border.all(color: Colors.black87, width: 2)
              : isSelected
                  ? Border.all(color: Colors.black, width: 2.5)
                  : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isOtherMonth
                  ? Colors.grey.withOpacity(0.4)
                  : fg,
            ),
          ),
        ),
      ),
    );
  }
}
