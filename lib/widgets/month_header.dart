import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';

class MonthHeader extends StatelessWidget {
  const MonthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final month = provider.focusedMonth;

    final monthName = _turkishMonth(month.month).toUpperCase();
    final title = '$monthName ${month.year}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: provider.previousMonth,
          icon: const Icon(Icons.chevron_left),
          color: Colors.grey[600],
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: Colors.black87,
          ),
        ),
        IconButton(
          onPressed: provider.nextMonth,
          icon: const Icon(Icons.chevron_right),
          color: Colors.grey[600],
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
