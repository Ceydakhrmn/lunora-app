import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../utils/phase_colors.dart';
import 'day_cell.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final month = provider.focusedMonth;

    final firstDay = DateTime(month.year, month.month, 1);
    int startOffset = firstDay.weekday - 1;

    final lastDay = DateTime(month.year, month.month + 1, 0);
    final daysInMonth = lastDay.day;

    final prevMonthLastDay = DateTime(month.year, month.month, 0).day;

    return Column(
      children: [
        _buildWeekdayHeader(),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 6,
            crossAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemCount: startOffset + daysInMonth + _trailingDays(startOffset, daysInMonth),
          itemBuilder: (context, index) {
            if (index < startOffset) {
              final day = prevMonthLastDay - startOffset + index + 1;
              return DayCell(label: '$day', isOtherMonth: true);
            }

            final dayIndex = index - startOffset;
            if (dayIndex >= daysInMonth) {
              final day = dayIndex - daysInMonth + 1;
              return DayCell(label: '$day', isOtherMonth: true);
            }

            final date = DateTime(month.year, month.month, dayIndex + 1);
            final phase = provider.phaseOf(date);
            final style = phaseStyle(phase);
            final isToday = _isToday(date);
            final isSelected = provider.selectedDay != null &&
                _isSameDay(provider.selectedDay!, date);

            return DayCell(
              label: '${date.day}',
              backgroundColor: style.background,
              textColor: style.textColor,
              isToday: isToday,
              isSelected: isSelected,
              onTap: () => provider.selectDay(date),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader() {
    const days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Pzr'];
    return Row(
      children: days
          .map((d) => Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  int _trailingDays(int startOffset, int daysInMonth) {
    final total = startOffset + daysInMonth;
    final remainder = total % 7;
    return remainder == 0 ? 0 : 7 - remainder;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
