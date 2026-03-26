import 'package:flutter/material.dart';
import '../utils/phase_colors.dart';

class LegendRow extends StatelessWidget {
  const LegendRow({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _LegendItem(color: kPeriodPeak,  label: 'Regl (yoğun)'),
      _LegendItem(color: kPeriodLight, label: 'Regl (hafif)'),
      _LegendItem(color: kFertilePeak, label: 'Doğurganlık — en yüksek'),
      _LegendItem(color: kFertileMid,  label: 'Doğurganlık — orta'),
      _LegendItem(color: kFertileLow,  label: 'Doğurganlık — düşük'),
      _LegendItem(color: kOvulation,   label: 'Ovulasyon'),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: items.map((item) => _buildItem(item)).toList(),
    );
  }

  Widget _buildItem(_LegendItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.color,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          item.label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }
}

class _LegendItem {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});
}
