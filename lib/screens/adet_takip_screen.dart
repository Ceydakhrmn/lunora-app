import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AdetTakipScreen extends StatefulWidget {
  const AdetTakipScreen({super.key});

  @override
  State<AdetTakipScreen> createState() => _AdetTakipScreenState();
}

class _AdetTakipScreenState extends State<AdetTakipScreen> {
  // DateTime _focusedDay = DateTime.now(); // Kullanılmıyor, kaldırıldı
  DateTime? _selectedDay = DateTime.now();

  // Örnek veri: Her güne renk kodu ve marka işaretleyici
  final Map<DateTime, Color> _dayColors = {};
  final Set<DateTime> _orkidDays = {
    DateTime(2026, 3, 18),
    DateTime(2026, 3, 23),
  };

  @override
  void initState() {
    super.initState();
    // Örnek: Mart 2026 için bazı günlere renk ata
    for (int i = 1; i <= 31; i++) {
      final d = DateTime(2026, 3, i);
      if ([3, 24].contains(i)) {
        _dayColors[d] = Colors.pinkAccent; // Regl
      } else if ([13, 14, 15, 16, 17].contains(i)) {
        _dayColors[d] = Colors.orangeAccent; // Yumurtlama
      } else if ([2, 4, 5, 28, 29].contains(i)) {
        _dayColors[d] = Colors.blueAccent; // Normal
      } else if ([18, 23].contains(i)) {
        _dayColors[d] = Colors.blue.shade900; // Orkid günü
      } else {
        _dayColors[d] = Colors.grey.shade200;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            // Ay ve yıl başlığı
            Center(
              child: Text(
                'MART 2026',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Takvim
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: DateTime(2026, 3, 21),
                currentDay: DateTime(2026, 3, 21),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 24,
                headerVisible: false,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final color =
                        _dayColors[DateTime(day.year, day.month, day.day)] ??
                        Colors.grey.shade200;
                    final isOrkid = _orkidDays.contains(
                      DateTime(day.year, day.month, day.day),
                    );
                    return Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            child: isOrkid
                                ? Center(
                                    child: Text(
                                      'Orkid',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          Text(
                            '${day.day}',
                            style: TextStyle(
                              color: isOrkid ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    final color =
                        _dayColors[DateTime(day.year, day.month, day.day)] ??
                        Colors.grey.shade200;
                    final isOrkid = _orkidDays.contains(
                      DateTime(day.year, day.month, day.day),
                    );
                    return Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: isOrkid
                                ? Center(
                                    child: Text(
                                      'Orkid',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: isOrkid ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                width: 18,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  weekendStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.black),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Belirti Gir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                    ),
                    icon: const Icon(Icons.water_drop, color: Colors.white),
                    label: const Text(
                      'Regl Başlat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade100.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.pink,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Bugün tahmini reglinin 4. günü',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
