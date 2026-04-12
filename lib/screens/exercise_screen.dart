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
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _titleForMode(mode),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _subtitleForMode(mode),
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.55)
                      : Colors.black45,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: exercises.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
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
      case AppMode.reglTakip:    return 'Regl Dönemi Egzersizleri';
      case AppMode.hamileTakip:  return 'Hamilelik Egzersizleri';
      case AppMode.hamilleKalma: return 'Doğurganlık Egzersizleri';
    }
  }

  String _subtitleForMode(AppMode mode) {
    switch (mode) {
      case AppMode.reglTakip:    return 'Sancıları azaltmaya yardımcı hafif hareketler';
      case AppMode.hamileTakip:  return 'Güvenli gerilme ve nefes egzersizleri';
      case AppMode.hamilleKalma: return 'Pelvik taban ve kan dolaşımını destekleyen hareketler';
    }
  }

  List<ExerciseData> _exercisesForMode(AppMode mode) {
    switch (mode) {
      case AppMode.reglTakip:
        return [
          ExerciseData(
            name: 'Yay Pozu',
            description: 'Karın kaslarını esnetir, krampları hafifletir.',
            benefits: ['Kramp ağrısı', 'Karın gerginliği', 'Sırt ağrısı', 'Stres'],
            steps: [
              'Yüz üstü yat, kollar yanında',
              'Dizleri büküp topukları kalçaya yaklaştır',
              'Ellerinle ayak bileklerini tut',
              'Nefes verirken gövdeyi ve bacakları yerden kaldır',
              '20–30 sn tut, salın',
            ],
            type: ExerciseType.bow,
          ),
          ExerciseData(
            name: 'Çocuk Pozu',
            description: 'Alt sırt ve karın kaslarını gevşetir.',
            benefits: ['Alt sırt ağrısı', 'Karın krampı', 'Zihin rahatlaması', 'Gerginlik'],
            steps: [
              'Diz üstü otur, topukların üstüne çök',
              'Kolları öne uzatarak öne eğil',
              'Alnını yere koy',
              'Derin nefes al, her nefeste biraz daha gevşe',
              '1–2 dakika bekle',
            ],
            type: ExerciseType.child,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Tüm vücudu esnetir, kan dolaşımını artırır.',
            benefits: ['Baş ağrısı', 'Sırt ağrısı', 'Yorgunluk', 'Kan dolaşımı'],
            steps: [
              'Dörtnala pozisyona geç',
              'Parmak uçlarına bas, dizleri yerden kaldır',
              'Kalçayı yukarı iterek ters V oluştur',
              'Topukları yere basmaya çalış',
              '5 nefes tut, tekrarla',
            ],
            type: ExerciseType.downDog,
          ),
          ExerciseData(
            name: 'Yatarak Tanrıça',
            description: 'Kalça ve pelvik bölgeyi rahatlatır.',
            benefits: ['Pelvik ağrı', 'Kalça gerginliği', 'İç uyluk', 'Rahatlama'],
            steps: [
              'Sırt üstü uzan, dizleri büküp ayak tabanlarını birleştir',
              'Dizlerin yana doğru düşmesine izin ver',
              'Kolları iki yana aç, avuçlar yukarı',
              'Gözleri kapat, derin nefes al',
              '2–3 dakika hareketsiz kal',
            ],
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Şişliği ve ağrıyı azaltır.',
            benefits: ['Bacak şişliği', 'Yorgunluk', 'Bel ağrısı', 'Kan dolaşımı'],
            steps: [
              'Duvara yakın yan uzan',
              'Bacakları yukarı kaldırıp duvara daya',
              'Kolları iki yana aç, rahatla',
              'Bacakları mümkün olduğunca dik tut',
              '5–10 dakika bekle',
            ],
            type: ExerciseType.legsUpWall,
          ),
          ExerciseData(
            name: 'Deve Pozu',
            description: 'Karın ve pelvik bölgeyi esnetir.',
            benefits: ['Karın krampı', 'Pelvik açılım', 'Omurga esnekliği', 'Enerji'],
            steps: [
              'Diz üstünde dik otur',
              'Elleri bele koy, dirsekler arkada',
              'Göğsü öne açarken başı geriye at',
              'İleri gidebilirsen elleri topuklara götür',
              '20–30 sn tut, yavaşça dön',
            ],
            type: ExerciseType.camel,
          ),
          ExerciseData(
            name: 'Kelebek Pozu',
            description: 'İç uylukları ve kasığı esnetir.',
            benefits: ['Pelvik gerginlik', 'İç uyluk', 'Kramp', 'Dolaşım'],
            steps: [
              'Otur, ayak tabanlarını birleştir',
              'Topukları kasığa çek',
              'Elleri ayakların üstünde kilitle',
              'Omurgayı dik tut, diz ve kasığı aşağı bırak',
              '1–2 dk tut, dizleri kelebek gibi salla',
            ],
            type: ExerciseType.butterfly,
          ),
        ];

      case AppMode.hamileTakip:
        return [
          ExerciseData(
            name: 'Çocuk Pozu',
            description: 'Sırt ağrısını azaltır, nefes almayı kolaylaştırır.',
            benefits: ['Sırt ağrısı', 'Nefes', 'Rahatlama', 'Gerilim'],
            steps: [
              'Diz üstü otur, topukların üstüne çök',
              'Kolları öne uzatarak öne eğil',
              'Alnını yere ya da bir yastığa koy',
              'Derin nefes alarak bebeğe yer aç',
              '1–2 dakika bekle',
            ],
            type: ExerciseType.child,
          ),
          ExerciseData(
            name: 'Yatarak Tanrıça',
            description: 'Doğuma hazırlık için kalça açıcı hareket.',
            benefits: ['Kalça açılımı', 'Doğuma hazırlık', 'Pelvik gevşeme', 'Rahatlama'],
            steps: [
              'Sırt üstü uzan',
              'Dizleri büküp ayak tabanlarını birleştir',
              'Dizlerin yana düşmesine izin ver',
              'Elleri göbek üstüne koy, bebeği hisset',
              '3–5 dakika derin nefesle kal',
            ],
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Ayak şişliğini azaltır.',
            benefits: ['Ayak şişliği', 'Bacak yorgunluğu', 'Kan dolaşımı', 'Rahatlama'],
            steps: [
              'Duvara yakın yan uzan',
              'Bacakları yukarı kaldırıp duvara daya',
              'Kolları iki yana aç',
              'Derin nefes al, rahatla',
              '5–10 dakika bekle',
            ],
            type: ExerciseType.legsUpWall,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Omurgayı uzatır, sırt ağrısını giderir.',
            benefits: ['Sırt ağrısı', 'Omurga', 'Enerji', 'Kan dolaşımı'],
            steps: [
              'Dörtnala pozisyona geç',
              'Kalçayı yukarı iterek ters V oluştur',
              'Topukları yere basmaya çalış',
              'Başı kollar arasında serbest bırak',
              '5 nefes tut, tekrarla',
            ],
            type: ExerciseType.downDog,
          ),
        ];

      case AppMode.hamilleKalma:
        return [
          ExerciseData(
            name: 'Yatarak Tanrıça',
            description: 'Pelvik taban kaslarını aktive eder.',
            benefits: ['Pelvik taban', 'Doğurganlık', 'Hormon dengesi', 'Rahatlama'],
            steps: [
              'Sırt üstü uzan',
              'Dizleri büküp ayak tabanlarını birleştir',
              'Derin nefes alırken pelvik tabanı gevşet',
              'Nefes verirken hafifçe kas',
              '10 tekrar yap',
            ],
            type: ExerciseType.recliningGoddess,
          ),
          ExerciseData(
            name: 'Kelebek Pozu',
            description: 'Pelvik bölgeyi açar, kan dolaşımını artırır.',
            benefits: ['Pelvik açılım', 'Kan dolaşımı', 'Doğurganlık', 'Gerilim'],
            steps: [
              'Otur, ayak tabanlarını birleştir',
              'Topukları kasığa çek',
              'Omurgayı dik tut',
              'Her nefeste kasıkların biraz daha açılmasına izin ver',
              '2–3 dakika kal',
            ],
            type: ExerciseType.butterfly,
          ),
          ExerciseData(
            name: 'Aşağı Bakan Köpek',
            description: 'Hormonal dengeyi destekler, stresi azaltır.',
            benefits: ['Hormon dengesi', 'Stres', 'Kan dolaşımı', 'Enerji'],
            steps: [
              'Dörtnala pozisyona geç',
              'Kalçayı yukarı iterek ters V oluştur',
              'Derin nefes al, kafayı serbest bırak',
              'Topukları yere basmaya çalış',
              '5–8 nefes tut',
            ],
            type: ExerciseType.downDog,
          ),
          ExerciseData(
            name: 'Bacaklar Duvarda',
            description: 'Pelvik bölgeye kan akışını artırır.',
            benefits: ['Pelvik kan akışı', 'Doğurganlık', 'Yorgunluk', 'Rahatlama'],
            steps: [
              'Duvara yakın yan uzan',
              'Bacakları duvara dayayarak yukarı kaldır',
              'Kolları yana aç, gözleri kapat',
              'Derin nefes al, pelvikte ısıyı hisset',
              '10 dakika kal',
            ],
            type: ExerciseType.legsUpWall,
          ),
        ];
    }
  }
}
