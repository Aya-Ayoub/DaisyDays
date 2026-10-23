import 'package:flutter/material.dart';

import '../app_theme.dart';

class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  State<MoodJournalScreen> createState() => _MoodJournalScreenState();
}

class _MoodJournalScreenState extends State<MoodJournalScreen> {
  final TextEditingController _journalController = TextEditingController();

  String? _selectedMood;

  final List<_MoodOption> _moods = [
    _MoodOption('Happy', '😊', 'A little sunshine'),
    _MoodOption('Calm', '😌', 'Peaceful and relaxed'),
    _MoodOption('Loved', '🥰', 'Feeling connected'),
    _MoodOption('Tired', '😴', 'Needing some rest'),
    _MoodOption('Anxious', '🥺', 'A lot on my mind'),
    _MoodOption('Sad', '😔', 'Taking it one step at a time'),
  ];

  final List<_JournalEntry> _entries = [];

  void _saveEntry() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Choose how you feel first 💗')),
      );
      return;
    }

    final note = _journalController.text.trim();

    setState(() {
      _entries.insert(
        0,
        _JournalEntry(mood: _selectedMood!, note: note, date: DateTime.now()),
      );

      _journalController.clear();
      _selectedMood = null;
    });

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Your little reflection has been saved 🌷')),
    );
  }

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Mood Journal 💗',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Check in with yourself. Every feeling deserves kindness.',
              style: TextStyle(fontSize: 14, color: AppTheme.softBrown),
            ),
            const SizedBox(height: 22),

            // Gentle daily check-in
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.palePink,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: AppTheme.deepRose,
                    size: 30,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.deepRose,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'There is no right or wrong answer. Take a moment for you.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: AppTheme.softBrown,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            const Text(
              'Choose your mood',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 12),

            // Mood selection grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _moods.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.65,
              ),
              itemBuilder: (context, index) {
                final mood = _moods[index];
                final isSelected = _selectedMood == mood.name;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedMood = mood.name;
                    });
                  },
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.palePink : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.deepRose
                            : AppTheme.blushPink,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(mood.emoji, style: const TextStyle(fontSize: 27)),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mood.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppTheme.deepRose,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                mood.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.softBrown,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 17,
                            color: AppTheme.deepRose,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            const Text(
              'A little note to yourself',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'What is on your mind? You can write as much or as little as you like.',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppTheme.softBrown,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _journalController,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Dear diary, today I feel...',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppTheme.blushPink),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: AppTheme.blushPink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppTheme.deepRose,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveEntry,
                icon: const Icon(Icons.favorite_rounded),
                label: const Text('Save my reflection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.deepRose,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'My reflections',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.deepRose,
                    ),
                  ),
                ),
                Text(
                  '${_entries.length} ${_entries.length == 1 ? 'entry' : 'entries'}',
                  style: const TextStyle(
                    color: AppTheme.softBrown,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (_entries.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.blushPink),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      size: 35,
                      color: AppTheme.deepRose,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your journal starts here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.deepRose,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Save your first reflection whenever you feel ready.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppTheme.softBrown),
                    ),
                  ],
                ),
              )
            else
              ..._entries.map((entry) {
                final mood = _moods.firstWhere(
                  (item) => item.name == entry.mood,
                );

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.blushPink),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            mood.emoji,
                            style: const TextStyle(fontSize: 27),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.mood,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.deepRose,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.softBrown,
                            ),
                          ),
                        ],
                      ),
                      if (entry.note.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          entry.note,
                          style: const TextStyle(
                            height: 1.5,
                            color: AppTheme.softBrown,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),

            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Be kind to your heart, lovely 🌼',
                style: TextStyle(
                  color: AppTheme.softBrown,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodOption {
  const _MoodOption(this.name, this.emoji, this.description);

  final String name;
  final String emoji;
  final String description;
}

class _JournalEntry {
  const _JournalEntry({
    required this.mood,
    required this.note,
    required this.date,
  });

  final String mood;
  final String note;
  final DateTime date;
}
