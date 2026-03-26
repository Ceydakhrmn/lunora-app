import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/month_header.dart';
import '../widgets/info_card.dart';
import '../widgets/legend_row.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.calendar_month, color: Colors.pink, size: 28),
          title: null,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.black54),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const _SwipeableCalendar(),
        ),
      );
    }
  }

  // HomeScreen'in dışına taşındı
  class _SwipeableCalendar extends StatefulWidget {
    const _SwipeableCalendar();
    @override
    State<_SwipeableCalendar> createState() => _SwipeableCalendarState();
  }

  class _SwipeableCalendarState extends State<_SwipeableCalendar> {
    late PageController _pageController;
    int _initialPage = 0;

    @override
    void initState() {
      super.initState();
      final now = DateTime.now();
      _initialPage = (now.year - 2000) * 12 + now.month;
      _pageController = PageController(initialPage: _initialPage);
    }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final provider = context.watch<CycleProvider>();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (page) {
                final year = 2000 + (page ~/ 12);
                final month = (page % 12) + 1;
                provider.setMonth(DateTime(year, month));
              },
              itemBuilder: (context, page) {
                final year = 2000 + (page ~/ 12);
                final month = (page % 12) + 1;
                return Center(
                  child: Text(
                    '${_turkishMonth(month).toUpperCase()} $year',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
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
                    provider.startPeriod(DateTime.now());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Regl başlatıldı!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.water_drop, size: 16),
                  label: const Text('REGL BAŞLAT'),
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
          const SizedBox(height: 18),
          const LegendRow(),
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

  // Swipe ile aylar arası geçiş için PageView tabanlı widget
  class _SwipeableCalendar extends StatefulWidget {
    @override
    State<_SwipeableCalendar> createState() => _SwipeableCalendarState();
  }

  class _SwipeableCalendarState extends State<_SwipeableCalendar> {
    late PageController _pageController;
    int _initialPage = 0;

    @override
    void initState() {
      super.initState();
      final provider = context.read<CycleProvider>();
      final now = DateTime.now();
      // Şu anki ayı ortadaki sayfa yap
      _initialPage = (now.year - 2000) * 12 + now.month;
      _pageController = PageController(initialPage: _initialPage);
    }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final provider = context.watch<CycleProvider>();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (page) {
                final year = 2000 + (page ~/ 12);
                final month = (page % 12) + 1;
                provider.setMonth(DateTime(year, month));
              },
              itemBuilder: (context, page) {
                final year = 2000 + (page ~/ 12);
                final month = (page % 12) + 1;
                return Center(
                  child: Text(
                    '${_turkishMonth(month).toUpperCase()} $year',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
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
                    provider.startPeriod(DateTime.now());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Regl başlatıldı!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.water_drop, size: 16),
                  label: const Text('REGL BAŞLAT'),
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
          const SizedBox(height: 18),
          const LegendRow(),
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
    );
  }
}
