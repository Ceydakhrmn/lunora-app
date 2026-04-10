import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../screens/stats_screen.dart';

class CycleSummaryCard extends StatelessWidget {
  const CycleSummaryCard({super.key});

  static const Color kPurple     = Color(0xFF7C3AED);
  static const Color kPurpleLight= Color(0xFFC084FC);
  static const Color kBlue       = Color(0xFF3B82F6);
  static const Color kGrey       = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final now      = DateTime.now();
    final start    = provider.cycle.cycleStart;
    final cLen     = provider.cycleLength;
    final pLen     = provider.periodLength;

    // Geçmiş döngüler (en fazla 3 tane, en yeni üstte)
    final List<DateTime> pastStarts = [];
    DateTime s = start;
    while (pastStarts.length < 3) {
      pastStarts.add(s);
      s = s.subtract(Duration(days: cLen));
    }

    final daysAgo = now.difference(start).inDays;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9D5FF), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: kPurple.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Başlık ──
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsScreen()),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                children: [
                  const Text(
                    'Genel Döngü Özetin',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right, color: kPurple, size: 20),
                ],
              ),
            ),
          ),

          // ── Döngü Geçmişi başlığı ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Row(
              children: [
                Text(
                  'Döngü Geçmişi',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kPurple,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: kPurple, size: 16),
              ],
            ),
          ),

          // ── Döngü listesi ──
          ...pastStarts.asMap().entries.map((e) {
            final idx        = e.key;
            final cycleStart = e.value;
            final cycleEnd   = cycleStart.add(Duration(days: cLen - 1));
            final isCurrentCycle = idx == 0;
            final actualLen  = isCurrentCycle
                ? now.difference(cycleStart).inDays + 1
                : cLen;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: isCurrentCycle
                              ? 'Şu Anki Döngü: '
                              : '$actualLen Gün: ',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: isCurrentCycle
                              ? 'Başlangıç ${_fmt(cycleStart)} ($cLen gün)'
                              : '${_fmt(cycleStart)} - ${_fmt(cycleEnd)}',
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 2),
                  child: Text(
                    '$pLen günlük süre',
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: _CycleBar(
                    cycleLength: cLen,
                    periodLength: pLen,
                    filled: isCurrentCycle ? (now.difference(cycleStart).inDays + 1) : cLen,
                  ),
                ),
                if (idx < pastStarts.length - 1)
                  const Divider(height: 1, indent: 16, endIndent: 16),
              ],
            );
          }),

          const Divider(height: 1),

          // ── Özet başlığı ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Row(
              children: [
                Text(
                  'Özetin',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kPurple,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: kPurple, size: 16),
              ],
            ),
          ),

          // ── Özet satırları ──
          _SummaryRow(
            label: 'Son Adet Dönemi',
            value: 'Başlangıç: ${_fmtFull(start)}',
            sub: '${daysAgo > 0 ? daysAgo : 0} Gün Önce',
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SummaryRow(
            label: 'Normal Adet Süresi',
            value: '$pLen Gün',
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SummaryRow(
            label: 'Normal Döngü Süresi',
            value: '$cLen Gün',
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  String _fmt(DateTime d) {
    const months = ['', 'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz',
                    'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];
    return '${d.day} ${months[d.month]}';
  }

  String _fmtFull(DateTime d) {
    const months = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
                    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return '${d.day} ${months[d.month]}';
  }
}

// ── Döngü bar widget'ı ──
class _CycleBar extends StatelessWidget {
  final int cycleLength;
  final int periodLength;
  final int filled; // kaç gün geçti

  const _CycleBar({
    required this.cycleLength,
    required this.periodLength,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    // Ovulasyon günü (döngü uzunluğu - 14)
    final ovDay = cycleLength - 14;
    // Doğurganlık penceresi: ovDay-5 → ovDay+1
    final fertStart = ovDay - 5;
    final fertEnd   = ovDay + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(cycleLength, (i) {
          final day = i + 1;
          Color col;

          if (day <= periodLength) {
            // Regl — mor tonları
            col = day <= 2
                ? const Color(0xFF7C3AED)
                : const Color(0xFFC084FC);
          } else if (day >= fertStart && day <= fertEnd) {
            // Doğurganlık + ovulasyon — mavi
            col = const Color(0xFF3B82F6);
          } else {
            col = const Color(0xFFE5E7EB);
          }

          // Geçmemiş günler soluk
          final opacity = day <= filled ? 1.0 : 0.45;

          return Container(
            width: 10,
            height: 16,
            margin: const EdgeInsets.only(right: 2),
            decoration: BoxDecoration(
              color: col.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }
}

// ── Özet satırı widget'ı ──
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;

  const _SummaryRow({required this.label, required this.value, this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black45)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(sub!, style: const TextStyle(fontSize: 11, color: Colors.black38)),
          ],
        ],
      ),
    );
  }
}
