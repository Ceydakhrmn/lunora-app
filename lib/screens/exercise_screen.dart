import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';
import '../widgets/exercise_card.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _trimester = 1;
  bool _warningExpanded = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final mode = provider.appMode;
    final exercises = _exercisesForMode(mode, _trimester);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Başlık satırı ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _titleForMode(mode),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const Spacer(),
                // Uyarı butonu — sadece hamileTakip modunda
                if (mode == AppMode.hamileTakip)
                  GestureDetector(
                    onTap: () => setState(() => _warningExpanded = !_warningExpanded),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _warningExpanded
                            ? const Color(0xFFFBBF24)
                            : (isDark ? const Color(0xFF2C1A1A) : const Color(0xFFFFF7ED)),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFBBF24),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        size: 20,
                        color: _warningExpanded
                            ? Colors.white
                            : const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Trimester seçici (hamileTakip) — başlığın hemen altında tam genişlik ──
          if (mode == AppMode.hamileTakip) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _TrimesterPicker(
                selected: _trimester,
                onChanged: (t) => setState(() => _trimester = t),
              ),
            ),
          ],

          // ── Alt başlık (regl / doğurganlık) ──
          if (mode != AppMode.hamileTakip)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Text(
                _subtitleForMode(mode),
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white.withValues(alpha: 0.55) : Colors.black45,
                ),
              ),
            ),

          const SizedBox(height: 8),

          // ── Açılır uyarı paneli ──
          if (mode == AppMode.hamileTakip && _warningExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: const _PregnancyWarningCard(),
            ),

          // ── Egzersiz listesi ──
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => ExerciseCard(data: exercises[index]),
            ),
          ),
        ],
      ),
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
      case AppMode.hamileTakip:  return '';
      case AppMode.hamilleKalma: return 'Pelvik taban ve kan dolaşımını destekleyen hareketler';
    }
  }

  List<ExerciseData> _exercisesForMode(AppMode mode, int trimester) {
    switch (mode) {
      case AppMode.reglTakip:
        return _reglExercises();
      case AppMode.hamileTakip:
        switch (trimester) {
          case 1: return _trimester1Exercises();
          case 2: return _trimester2Exercises();
          case 3: return _trimester3Exercises();
          default: return _trimester1Exercises();
        }
      case AppMode.hamilleKalma:
        return _fertilityExercises();
    }
  }

  // ── Regl egzersizleri ──
  List<ExerciseData> _reglExercises() => [
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

  // ── 1. Trimester ──
  List<ExerciseData> _trimester1Exercises() => [
    ExerciseData(
      name: 'Oturan Kedi-İnek',
      description: 'Omurgayı mobilize eder, bulantıyı azaltır.',
      benefits: ['Sırt ağrısı', 'Bulantı', 'Omurga', 'Esneklik'],
      steps: [
        'Dörtnala pozisyona geç',
        'Nefes alırken beli aşağı bırak, başı kaldır (inek)',
        'Nefes verirken sırtı yukarı kaldır, çene göğse (kedi)',
        'Yavaş ve akıcı şekilde tekrarla',
        '10 tekrar yap',
      ],
      type: ExerciseType.oturanKediInek,
    ),
    ExerciseData(
      name: 'Yan Vücut Esnetme',
      description: 'Büyüyen rahme alan açar, yan kasları esnetir.',
      benefits: ['Yan ağrı', 'Esneklik', 'Rahatlama', 'Nefes'],
      steps: [
        'Ayakta ya da oturarak dik dur',
        'Bir kolunu başın üzerinden karşı yana uzan',
        'Diğer eli kalça ya da sandalye kenarında tut',
        'Yan tarafta esneyi hisset, 3 nefes kal',
        'Diğer tarafa geç, tekrarla',
      ],
      type: ExerciseType.yanVucutEstretme,
    ),
    ExerciseData(
      name: 'Aşağı Bakan Köpek',
      description: 'Omurgayı uzatır, enerji verir.',
      benefits: ['Sırt ağrısı', 'Yorgunluk', 'Kan dolaşımı', 'Enerji'],
      steps: [
        'Dörtnala pozisyona geç',
        'Kalçayı yukarı iterek ters V oluştur',
        'Topukları yere basmaya çalış',
        'Başı kollar arasında serbest bırak',
        '5 nefes tut, tekrarla',
      ],
      type: ExerciseType.asagiBakanKopek,
    ),
    ExerciseData(
      name: 'Ters Savaşçı',
      description: 'Denge ve güç geliştirir, yan kasları açar.',
      benefits: ['Denge', 'Güç', 'Yan kaslar', 'Enerji'],
      steps: [
        'Savaşçı 2 pozisyonuna geç',
        'Ön kolu arka bacak üzerine kaydır',
        'Diğer kolu başın üzerinden uzan',
        'Göğsü açık tut, nefes al',
        '3–5 nefes kal, taraf değiştir',
      ],
      type: ExerciseType.tersSavasci,
    ),
  ];

  // ── 2. Trimester ──
  List<ExerciseData> _trimester2Exercises() => [
    ExerciseData(
      name: 'Sandalye Duruşu',
      description: 'Bacak ve kalça kaslarını güçlendirir.',
      benefits: ['Bacak gücü', 'Denge', 'Kalça', 'Doğuma hazırlık'],
      steps: [
        'Ayakları omuz genişliğinde aç',
        'Kolları öne uzat ya da kalçada tut',
        'Dizleri bükerek sandalyeye oturur gibi aşağı in',
        'Sırtı dik tut, dizler ayak parmakları hizasında',
        '5–8 nefes kal, tekrarla',
      ],
      type: ExerciseType.sandakyeDurusu,
    ),
    ExerciseData(
      name: 'Tanrıça Çömelmesi',
      description: 'Pelvik tabanı güçlendirir, doğuma hazırlar.',
      benefits: ['Pelvik taban', 'Doğuma hazırlık', 'Kalça açılımı', 'Güç'],
      steps: [
        'Ayakları geniş aç, parmaklar dışa bak',
        'Kolları göğüs hizasında Namaste ya da yana aç',
        'Dizleri ayak yönünde bükerek çömel',
        'Omurgayı dik tut, nefes al',
        '5–10 nefes kal',
      ],
      type: ExerciseType.tanricaComelmesi,
    ),
    ExerciseData(
      name: 'Geniş Bacaklı Öne Eğilme',
      description: 'İç uyluk ve sırtı esnetir.',
      benefits: ['İç uyluk', 'Sırt esnekliği', 'Pelvik alan', 'Rahatlama'],
      steps: [
        'Ayakları geniş aç',
        'Elleri bele koy, sırtı düz tut',
        'Öne doğru yavaşça eğil',
        'Elleri yere ya da blok üstüne koy',
        '5 nefes kal, yavaşça kalk',
      ],
      type: ExerciseType.genisBacakliOneEgilme,
    ),
    ExerciseData(
      name: 'Ters Savaşçı 2',
      description: 'Yan kasları ve omurgayı esnetir.',
      benefits: ['Yan kaslar', 'Denge', 'Güç', 'Omurga'],
      steps: [
        'Savaşçı 2 pozisyonuna geç',
        'Arka kolu aşağı kaydır, ön kolu yukarı uzan',
        'Başı yukarıdaki ele doğru çevir',
        'Göğsü açık tut, nefes al',
        '3–5 nefes kal, taraf değiştir',
      ],
      type: ExerciseType.tersSavasci2,
    ),
  ];

  // ── 3. Trimester ──
  List<ExerciseData> _trimester3Exercises() => [
    ExerciseData(
      name: 'Dizler Açık Çocuk Pozu',
      description: 'Karnа yer açar, sırt ve kalçayı rahatlatır.',
      benefits: ['Sırt ağrısı', 'Kalça', 'Rahatlama', 'Nefes'],
      steps: [
        'Diz üstü otur, dizleri geniş aç',
        'Ayak parmakları birleşik kalsın',
        'Kolları öne uzatarak öne eğil',
        'Karın için dizler arasında yer var',
        '1–2 dakika derin nefesle kal',
      ],
      type: ExerciseType.dizlerAcikCocukPozu,
    ),
    ExerciseData(
      name: 'Destekli Çömelme',
      description: 'Pelvik tabanı açar, doğum kanalını hazırlar.',
      benefits: ['Doğuma hazırlık', 'Pelvik açılım', 'Bacak gücü', 'Rahatlama'],
      steps: [
        'Sırtını duvara daya ya da yastık/blok kullan',
        'Ayakları geniş açarak çömel',
        'Elleri Namaste ya da dizlerin üstünde',
        'Pelvik tabanı gevşet, derin nefes al',
        '5–10 nefes kal',
      ],
      type: ExerciseType.destekliComelme,
    ),
    ExerciseData(
      name: 'Top Üzerinde Kalça Daireleri',
      description: 'Bebeği doğru pozisyona yönlendirir, bel ağrısını azaltır.',
      benefits: ['Bel ağrısı', 'Bebek pozisyonu', 'Pelvik rahatlama', 'Dolaşım'],
      steps: [
        'Doğum topuna otur, ayaklar yerde sabit',
        'Kalçayla yavaş yavaş daire çiz',
        'Saat yönünde 10 daire',
        'Ters yönde 10 daire',
        'Her gün tekrarla',
      ],
      type: ExerciseType.topUzerindeKalcaDaireleri,
    ),
    ExerciseData(
      name: 'Duvara Bacak Uzatma',
      description: 'Ayak şişliğini azaltır, kan dolaşımını artırır.',
      benefits: ['Ayak şişliği', 'Yorgunluk', 'Kan dolaşımı', 'Rahatlama'],
      steps: [
        'Duvara yakın yan uzan',
        'Bacakları duvara dayayarak yukarı kaldır',
        'Kolları yana aç, gözleri kapat',
        'Derin nefes al',
        '5–10 dakika kal',
      ],
      type: ExerciseType.duvara,
    ),
  ];

  // ── Doğurganlık egzersizleri ──
  List<ExerciseData> _fertilityExercises() => [
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

// ── Trimester seçici widget ──
class _TrimesterPicker extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const _TrimesterPicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2840) : const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF3D2A5E) : const Color(0xFFD8B4FE),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [1, 2, 3].map((t) {
          final isSelected = selected == t;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF7C3AED) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$t. Trimester',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white54 : const Color(0xFF7C3AED)),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PregnancyWarningCard extends StatelessWidget {
  const _PregnancyWarningCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C1A1A) : const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFBBF24),
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFF59E0B), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Hamilelikte Riskli Pozlar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Hamileliğin hangi aşamasında olursan ol, aşağıdaki pozlar riskli kabul edilir:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ..._riskyItems.map((item) => _RiskyItem(text: item, isDark: isDark)),
          const SizedBox(height: 12),
          Divider(color: isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFBBF24), height: 1),
          const SizedBox(height: 12),
          // Acil durum başlığı
          Row(
            children: [
              const Icon(Icons.local_hospital_rounded, color: Color(0xFFEF4444), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Egzersizi anında bırakıp doktorunu araman gereken durumlar:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFFFCA5A5) : const Color(0xFFDC2626),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._emergencyItems.map((item) => _BulletItem(text: item, isDark: isDark)),
          const SizedBox(height: 12),
          // Alt uyarı kutusu
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1B2E) : const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF4C1D95) : const Color(0xFFC4B5FD),
              ),
            ),
            child: Text(
              '⚠️  En iyi rehber kendi vücudundur. Eğer bir hareket "doğru" hissettirmiyorsa, o hareketi yapma. Eğitmenine mutlaka kaç haftalık hamile olduğunu belirtmeyi unutma!',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFC4B5FD) : const Color(0xFF5B21B6),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _riskyItems = [
    'a) Amuda Kalkma / Baş Üstü Duruş — Düşme riski ve yüksek tansiyon sebebiyle.',
    'b) Derin Geriye Eğilmeler (Deve Pozu vb.) — Karın kaslarını aşırı gerer.',
    'c) Karın Üstü Yatış — Bebeğe doğrudan baskı yapar.',
    'd) Derin Twistler (Bükülmeler) — Rahmi sıkıştırabilir.',
  ];

  static const _emergencyItems = [
    'Vajinal kanama veya sıvı gelişi.',
    'Şiddetli baş ağrısı veya baş dönmesi.',
    'Saatte 4\'ten fazla kasılma hissetmek.',
    'Baldırlarda aşırı ağrı veya ani şişlik.',
  ];
}

class _RiskyItem extends StatelessWidget {
  final String text;
  final bool isDark;
  const _RiskyItem({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.block_rounded, size: 13, color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.black87,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final bool isDark;
  const _BulletItem({required this.text, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 5, height: 5,
              decoration: const BoxDecoration(
                color: Color(0xFFEF4444),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.black87,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
