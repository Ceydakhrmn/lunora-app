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
  final ExerciseType type;
  const ExerciseData({required this.name, required this.description, required this.type});
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
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                exerciseImagePath(data.type),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.description,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}

