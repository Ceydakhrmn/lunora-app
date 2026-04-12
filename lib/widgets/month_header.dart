// =============================================
// widgets/month_header.dart
// Üstteki ay adı + ileri/geri ok butonları
// =============================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/cycle_provider.dart';

class MonthHeader extends StatelessWidget {
  const MonthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final month = provider.focusedMonth;

    // Ay adını Türkçe büyük harfle yaz
    final monthName = _turkishMonth(month.month).toUpperCase();
    final title = '$monthName ${month.year}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: provider.previousMonth,
          icon: const Icon(Icons.chevron_left),
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        IconButton(
          onPressed: provider.nextMonth,
          icon: const Icon(Icons.chevron_right),
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ],
    );
  }

  String _turkishMonth(int month) {
    const months = [
      '', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return months[month];
  }
}
