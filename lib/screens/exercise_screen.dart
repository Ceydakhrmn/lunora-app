import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../widgets/exercise_card.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final mode = provider.appMode;

    final List<ExerciseData> exercises = _exercisesForMode(mode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _titleForMode(mode),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _subtitleForMode(mode),
                style: const TextStyle(fontSize: 13, color: Colors.black45),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ExerciseCard(data: exercises[index]);
            },
          ),
        ),
      ],
    );
  }

  String _titleForMode(AppMode mode) {
    switch (mode) {
      case AppMode.reglTakip:
        return 'Regl Dönemi Egzersizleri';
      case AppMode.hamileTakip:
        return 'Hamilelik Egzersizleri';
      case AppMode.hamilleKalma:
        return 'Doğurganlık Egzersizleri';
    }
  }

  String _subtitleForMode(AppMode mode) {
    switch (mode) {
      case AppMode.reglTakip:
        return 'Sancıları azaltmaya yardımcı hafif hareketler';
      case AppMode.hamileTakip:
        return 'Güvenli gerilme ve nefes egzersizleri';
      case AppMode.hamilleKalma:
        return 'Pelvik taban ve kan dolaşımını destekleyen hareketler';
    }
  }

  List<ExerciseData> _exercisesForMode(AppMode mode) {
    switch (mode) {
      case AppMode.reglTakip:
        return [
          ExerciseData(
            name: 'Deve Pozu',
            description: 'Karın ve pelvik bölgeyi esnetir, kramp ağrısını azaltır.',
            type: ExerciseType.camel,
          ),
          ExerciseData(
            name: 'Çocuk Pozu',
            description: 'Alt sırt ve karın kaslarını gevşetir, rahatlatır.',
            type: ExerciseType.child,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Tüm vücudu esnetir, kan dolaşımını artırır.',
            type: ExerciseType.downDog,
          ),
          ExerciseData(
            name: 'Reclined Goddess',
            description: 'Kalça ve iç uylukları açar, pelvik bölgeyi rahatlatır.',
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Kan dolaşımını tersine çevirir, şişliği ve ağrıyı azaltır.',
            type: ExerciseType.legsUpWall,
          ),
          ExerciseData(
            name: 'Yay Pozu',
            description: 'Karın kaslarını esnetir, krampları hafifletir.',
            type: ExerciseType.bow,
          ),
          ExerciseData(
            name: 'Kelebek Pozu',
            description: 'İç uylukları ve kasığı esnetir, pelvik bölgeyi açar.',
            type: ExerciseType.butterfly,
          ),
        ];
      case AppMode.hamileTakip:
        return [
          ExerciseData(
            name: 'Çocuk Pozu',
            description: 'Sırt ağrısını azaltır, nefes almayı kolaylaştırır.',
            type: ExerciseType.child,
          ),
          ExerciseData(
            name: 'Reclined Goddess',
            description: 'Doğuma hazırlık için kalça açıcı hareket.',
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Ayak şişliğini azaltır, kan dolaşımını destekler.',
            type: ExerciseType.legsUpWall,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Omurgayı uzatır, sırt ağrısını giderir.',
            type: ExerciseType.downDog,
          ),
        ];
      case AppMode.hamilleKalma:
        return [
          ExerciseData(
            name: 'Reclined Goddess',
            description: 'Pelvik taban kaslarını aktive eder.',
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Deve Pozu',
            description: 'Pelvik bölgeyi açar, kan dolaşımını artırır.',
            type: ExerciseType.camel,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Hormonal dengeyi destekler, stresi azaltır.',
            type: ExerciseType.downDog,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Pelvik bölgeye kan akışını artırır.',
            type: ExerciseType.legsUpWall,
          ),
        ];
    }
  }
}
