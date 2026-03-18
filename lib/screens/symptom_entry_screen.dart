import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BelirtiEklemeSayfasi extends StatefulWidget {
  const BelirtiEklemeSayfasi({super.key});

  @override
  State<BelirtiEklemeSayfasi> createState() => _BelirtiEklemeSayfasiState();
}

class _BelirtiEklemeSayfasiState extends State<BelirtiEklemeSayfasi> {
  // Seçilen mod ve semptomları tutmak için listeler
  String selectedMood = "";
  List<String> selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bugün Nasıl Hissediyorsun?", 
          style: GoogleFonts.quicksand(color: const Color(0xFF6D5D6E), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF6D5D6E)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Mod Seçimi Section
            Text("Ruh Hali", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMoodIcon("😊", "Mutlu"),
                _buildMoodIcon("😔", "Üzgün"),
                _buildMoodIcon("😠", "Gergin"),
                _buildMoodIcon("😴", "Yorgun"),
              ],
            ),
            
            const SizedBox(height: 35),

            // 2. Fiziksel Belirtiler Section
            Text("Fiziksel Belirtiler", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildSymptomChip("Karın Ağrısı"),
                _buildSymptomChip("Baş Ağrısı"),
                _buildSymptomChip("Sivilce"),
                _buildSymptomChip("Şişkinlik"),
                _buildSymptomChip("Göğüs Hassasiyeti"),
                _buildSymptomChip("Bel Ağrısı"),
              ],
            ),

            const SizedBox(height: 40),

            // 3. Kaydet Butonu
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Veritabanına kaydetme işlemi buraya gelecek
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Belirtilerin başarıyla kaydedildi!")),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB19CD9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text("Kaydet", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Yardımcı Widget: Mod İkonu
  Widget _buildMoodIcon(String emoji, String label) {
    bool isSelected = selectedMood == label;
    return GestureDetector(
      onTap: () => setState(() => selectedMood = label),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFB19CD9).withValues(alpha: 0.2) : Colors.grey.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: isSelected ? const Color(0xFFB19CD9) : Colors.transparent, width: 2),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(height: 5),
          Text(label, style: GoogleFonts.quicksand(fontSize: 12)),
        ],
      ),
    );
  }

  // Yardımcı Widget: Belirti Seçim Kutusu (Chip)
  Widget _buildSymptomChip(String label) {
    bool isSelected = selectedSymptoms.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedSymptoms.add(label);
          } else {
            selectedSymptoms.remove(label);
          }
        });
      },
      selectedColor: const Color(0xFFFBC2EB).withValues(alpha: 0.3),
      checkmarkColor: const Color(0xFF6D5D6E),
      labelStyle: GoogleFonts.quicksand(color: const Color(0xFF6D5D6E)),
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
