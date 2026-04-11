import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';

class MoodOption {
  final String key;
  final String emoji;
  final String label;
  final String message;
  final Color color;

  const MoodOption({
    required this.key,
    required this.emoji,
    required this.label,
    required this.message,
    required this.color,
  });
}

const List<MoodOption> kMoods = [
  MoodOption(
    key: 'happy',
    emoji: '😊',
    label: 'Mutlu',
    message: 'Mutluluk her zaman seninle olsun! 🌟',
    color: Color(0xFFFDE68A),
  ),
  MoodOption(
    key: 'calm',
    emoji: '😌',
    label: 'Sakin',
    message: 'Bu huzur içinde kal, sen bunu hak ediyorsun 🌿',
    color: Color(0xFFBBF7D0),
  ),
  MoodOption(
    key: 'tired',
    emoji: '😴',
    label: 'Yorgun',
    message: 'Biraz dinlen, vücudun senden bunu istiyor 💤',
    color: Color(0xFFE0E7FF),
  ),
  MoodOption(
    key: 'sad',
    emoji: '😢',
    label: 'Üzgün',
    message: 'Bu da geçecek, her fırtınanın ardından güneş doğar ☀️',
    color: Color(0xFFBAE6FD),
  ),
  MoodOption(
    key: 'anxious',
    emoji: '😰',
    label: 'Endişeli',
    message: 'Derin bir nefes al, şu an güvendesin 🫶',
    color: Color(0xFFFED7AA),
  ),
  MoodOption(
    key: 'angry',
    emoji: '😤',
    label: 'Sinirli',
    message: 'Duyguların geçerli, kendine nazik ol 💜',
    color: Color(0xFFFECACA),
  ),
  MoodOption(
    key: 'energetic',
    emoji: '⚡',
    label: 'Enerjik',
    message: 'Bu enerjiyle bugün her şeyi yapabilirsin! 🚀',
    color: Color(0xFFFEF08A),
  ),
  MoodOption(
    key: 'sensitive',
    emoji: '🥺',
    label: 'Hassas',
    message: 'Hassasiyetin bir güç, kendine iyi bak 🌸',
    color: Color(0xFFF5D0FE),
  ),
];

MoodOption? moodByKey(String key) {
  try {
    return kMoods.firstWhere((m) => m.key == key);
  } catch (_) {
    return null;
  }
}

class MoodCard extends StatelessWidget {
  const MoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final selected = provider.selectedDay;
    final currentMood = selected != null ? provider.moodForDay(selected) : '';
    final selectedMood = moodByKey(currentMood);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF7C3AED), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(
            children: [
              const Icon(Icons.mood, size: 16, color: Color(0xFF7C3AED)),
              const SizedBox(width: 6),
              const Text(
                'Ruh Hali',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (selected == null)
                const Text(
                  'Önce bir gün seçin',
                  style: TextStyle(fontSize: 11, color: Colors.black38),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Emoji seçici
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kMoods.map((mood) {
              final isSelected = mood.key == currentMood;
              return GestureDetector(
                onTap: selected == null
                    ? null
                    : () {
                        final newMood = isSelected ? '' : mood.key;
                        provider.saveMood(selected, newMood);
                        if (newMood.isNotEmpty) {
                          _showMoodMessage(context, mood);
                        }
                      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? mood.color : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF7C3AED)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(mood.emoji, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      Text(
                        mood.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isSelected
                              ? const Color(0xFF4C1D95)
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Seçili ruh hali mesajı
          if (selectedMood != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: selectedMood.color.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                selectedMood.message,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4C1D95),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showMoodMessage(BuildContext context, MoodOption mood) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(mood.emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mood.message,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF7C3AED),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
