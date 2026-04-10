import 'package:flutter/material.dart';

enum ExerciseType {
  bow,               // Yay pozu
  recliningGoddess,  // Yatarak Tanrıça
  legsUpWall,        // Bacaklar duvara
  camel,             // Deve pozu
  downDog,           // Aşağı bakan köpek
  child,             // Çocuk pozu
  butterfly,         // Kelebek pozu
}

class ExerciseData {
  final String name;
  final String description;
  final List<String> benefits;   // nelere iyi gelir
  final List<String> steps;      // nasıl yapılır (adım adım)
  final ExerciseType type;

  const ExerciseData({
    required this.name,
    required this.description,
    required this.benefits,
    required this.steps,
    required this.type,
  });
}

String exerciseImagePath(ExerciseType type) {
  switch (type) {
    case ExerciseType.bow:              return 'assets/exercises/bow.jpeg';
    case ExerciseType.recliningGoddess: return 'assets/exercises/reclining_goddess.jpeg';
    case ExerciseType.legsUpWall:       return 'assets/exercises/legs_up_wall.jpeg';
    case ExerciseType.camel:            return 'assets/exercises/camel.jpeg';
    case ExerciseType.downDog:          return 'assets/exercises/down_dog.jpeg';
    case ExerciseType.child:            return 'assets/exercises/child.jpeg';
    case ExerciseType.butterfly:        return 'assets/exercises/butterfly.jpeg';
  }
}

class ExerciseCard extends StatelessWidget {
  final ExerciseData data;
  const ExerciseCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9D5FF), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Poz adı + nelere iyi gelir ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poz adı
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                // "X nelere iyi gelir?" başlığı
                Text(
                  '${data.name} nelere iyi gelir?',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C3AED),
                  ),
                ),
                const SizedBox(height: 6),
                // Etiketler
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: data.benefits.map((b) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EEFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // ── 2. Fotoğraf ──
          ClipRRect(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                exerciseImagePath(data.type),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          // ── 3. Nasıl yapılır ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nasıl yapılır?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.steps.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) => _StepCard(
                      number: i + 1,
                      text: data.steps[i],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int number;
  final String text;
  const _StepCard({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9D5FF), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFF7C3AED),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                height: 1.35,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
