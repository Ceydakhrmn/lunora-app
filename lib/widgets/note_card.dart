import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cycle_provider.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  final TextEditingController _noteController = TextEditingController();
  DateTime? _loadedDay;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CycleProvider>();
    final selected = provider.selectedDay;

    if (selected != _loadedDay) {
      _loadedDay = selected;
      final existing = selected != null ? provider.noteForDay(selected) : '';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _noteController.text = existing;
        _noteController.selection = TextSelection.collapsed(offset: existing.length);
      });
    }

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
          Row(
            children: [
              const Icon(Icons.edit_note, size: 16, color: Color(0xFF7C3AED)),
              const SizedBox(width: 6),
              const Text(
                'Not',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7C3AED),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _noteController,
            enabled: selected != null,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
            decoration: InputDecoration(
              hintText: selected == null
                  ? 'Önce bir gün seçin'
                  : 'Bugüne not ekle...',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              if (selected != null) {
                provider.saveNote(selected, value);
              }
            },
          ),
        ],
      ),
    );
  }
}
