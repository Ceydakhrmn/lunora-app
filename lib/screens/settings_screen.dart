// =============================================
// screens/settings_screen.dart
// =============================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Ayarlar',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: const [
          _GeneralSettingsSection(),
          _RemindersSection(),
          _CycleSettingsSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ---- Genel Ayarlar ----
class _GeneralSettingsSection extends StatelessWidget {
  const _GeneralSettingsSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();

    return _Section(
      title: 'Genel Ayarlar',
      icon: Icons.tune,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'Uygulama amacı',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        _ModeCard(
          title: 'Regl Takip',
          subtitle: 'Adet döngünüzü takip edin',
          icon: Icons.water_drop_outlined,
          selected: provider.appMode == AppMode.reglTakip,
          onTap: () => provider.updateAppMode(AppMode.reglTakip),
        ),
        const SizedBox(height: 8),
        _ModeCard(
          title: 'Hamile Takip',
          subtitle: 'Hamilelik sürecinizi takip edin',
          icon: Icons.pregnant_woman_outlined,
          selected: provider.appMode == AppMode.hamileTakip,
          onTap: () => provider.updateAppMode(AppMode.hamileTakip),
        ),
        const SizedBox(height: 8),
        _ModeCard(
          title: 'Hamile Kalma',
          subtitle: 'Doğurganlık pencerelerinizi takip edin',
          icon: Icons.favorite_outline,
          selected: provider.appMode == AppMode.hamilleKalma,
          onTap: () => provider.updateAppMode(AppMode.hamilleKalma),
        ),
      ],
    );
  }
}

// ---- Hatırlatıcılar ----
class _RemindersSection extends StatelessWidget {
  const _RemindersSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();

    return _Section(
      title: 'Hatırlatıcılar',
      icon: Icons.notifications_outlined,
      children: [
        _ReminderTile(
          title: 'Regl başlangıcı',
          subtitle: 'Regl başladığında bildirim al',
          value: provider.reminderPeriodStart,
          onChanged: provider.updateReminderPeriodStart,
        ),
        _ReminderTile(
          title: 'Regl bitişi',
          subtitle: 'Regl bittiğinde bildirim al',
          value: provider.reminderPeriodEnd,
          onChanged: provider.updateReminderPeriodEnd,
        ),
        _ReminderTile(
          title: 'Yumurtlama günü',
          subtitle: 'Yumurtlama gününde bildirim al',
          value: provider.reminderOvulation,
          onChanged: provider.updateReminderOvulation,
        ),
        _ReminderTile(
          title: 'Doğurganlık penceresi',
          subtitle: 'Doğurganlık dönemine girince bildirim al',
          value: provider.reminderFertile,
          onChanged: provider.updateReminderFertile,
        ),
      ],
    );
  }
}

// ---- Döngü Ayarları ----
class _CycleSettingsSection extends StatelessWidget {
  const _CycleSettingsSection();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();

    return _Section(
      title: 'Döngü',
      icon: Icons.loop,
      children: [
        const Text(
          'Ortalama döngü uzunluğu',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        _SliderTile(
          value: provider.cycleLength.toDouble(),
          min: 21,
          max: 40,
          divisions: 19,
          label: '${provider.cycleLength} gün',
          onChanged: (v) => provider.updateCycleLength(v.round()),
        ),
        const SizedBox(height: 16),
        const Text(
          'Regl süresi',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        _SliderTile(
          value: provider.periodLength.toDouble(),
          min: 2,
          max: 10,
          divisions: 8,
          label: '${provider.periodLength} gün',
          onChanged: (v) => provider.updatePeriodLength(v.round()),
        ),
      ],
    );
  }
}

// ---- Ortak bileşenler ----

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF7C3AED)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF3EEFF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF7C3AED) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? const Color(0xFF7C3AED) : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: selected ? const Color(0xFF7C3AED) : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFF7C3AED), size: 20),
          ],
        ),
      ),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ReminderTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF7C3AED),
          ),
        ],
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final ValueChanged<double> onChanged;

  const _SliderTile({
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: const Color(0xFF7C3AED),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 52,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
