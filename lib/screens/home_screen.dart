// =============================================
// screens/home_screen.dart
// Uygulamanın ana ekranı — takvimi içerir
// =============================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/month_header.dart';
import '../widgets/info_card.dart';
import '../widgets/note_card.dart';
import '../widgets/cycle_summary_card.dart';
import 'settings_screen.dart';

void showLegendDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text(
        'Sanırım yardıma ihtiyacın var.',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Renkler dönemleri gösterir. Ben de sana bu dönemlere göre tavsiyeler veririm ;)',
            style: TextStyle(fontSize: 13, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _LegendRow(color: const Color(0xFF7C3AED), label: 'Regl dönemi (yoğun).'),
          _LegendRow(color: const Color(0xFFC084FC), label: 'Regl dönemi (hafif).'),
          _LegendRow(color: const Color(0xFF3B82F6), label: 'Ovulasyon günü.'),
          _LegendRow(color: const Color(0xFFDC2626), label: 'Doğurganlık — en yüksek.'),
          _LegendRow(color: const Color(0xFFF97316), label: 'Doğurganlık — orta.'),
          _LegendRow(color: const Color(0xFFFDE047), label: 'Doğurganlık — düşük.'),
          _LegendRow(isBlend: true, label: 'Soluk renkli olanlar benim tahminimdir.'),
          _LegendRow(color: Colors.grey.shade300, label: 'Takvime bilgi girdiğini gösterir.'),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              side: const BorderSide(color: Colors.black12),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'ANLADIM',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _LegendRow extends StatelessWidget {
  final Color? color;
  final String label;
  final bool isBlend;
  const _LegendRow({
    this.color,
    required this.label,
    this.isBlend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (isBlend)
            SizedBox(
              width: 36, height: 36,
              child: Stack(children: [
                Positioned(left: 0, top: 4, child: Container(width: 20, height: 20,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        color: const Color(0xFF7C3AED).withValues(alpha: 0.4)))),
                Positioned(left: 8, top: 4, child: Container(width: 20, height: 20,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.4)))),
                Positioned(left: 4, top: 10, child: Container(width: 20, height: 20,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                        color: const Color(0xFFDC2626).withValues(alpha: 0.4)))),
              ]),
            )
          else
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();

    return Column(
      children: [
        Container(
          color: const Color(0xFFF5F0FF),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Color(0xFF7C3AED)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.info_outline, color: Color(0xFF7C3AED)),
                onPressed: () => showLegendDialog(context),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MonthHeader(),
                const SizedBox(height: 8),
                const CalendarGrid(),
                const SizedBox(height: 16),
                const InfoCard(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('BELİRTİ GİR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22c55e),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (provider.isPeriodActive) {
                            provider.endPeriod();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Regl bitirildi!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            provider.startPeriod(DateTime.now());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Regl başlatıldı!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.water_drop, size: 16),
                        label: Text(provider.isPeriodActive ? 'REGL BİTİR' : 'REGL BAŞLAT'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C3AED),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const NoteCard(),
                const SizedBox(height: 16),
                const CycleSummaryCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
