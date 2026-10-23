import 'package:flutter/material.dart';

import '../app_theme.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  final TextEditingController _habitController = TextEditingController();

  final List<_Habit> _habits = [
    _Habit('Drink a glass of water', Icons.water_drop_rounded),
    _Habit('Take a little screen break', Icons.spa_rounded),
    _Habit('Spend time on myself', Icons.favorite_rounded),
    _Habit(
      'Write down three things I am grateful for',
      Icons.edit_note_rounded,
    ),
  ];

  int get _completedCount => _habits.where((habit) => habit.isDone).length;

  double get _progress =>
      _habits.isEmpty ? 0 : _completedCount / _habits.length;

  void _addHabit() {
    final title = _habitController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit first 🌷')),
      );
      return;
    }

    setState(() {
      _habits.add(_Habit(title, Icons.check_circle_outline_rounded));
      _habitController.clear();
    });

    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _habitController.dispose();
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
              'Your Little Habits 🌷',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Small steps still count. Be gentle with yourself.',
              style: TextStyle(fontSize: 14, color: AppTheme.softBrown),
            ),
            const SizedBox(height: 22),

            // Daily progress card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.palePink,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_florist_rounded,
                        color: AppTheme.deepRose,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Your daily progress',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.deepRose,
                          ),
                        ),
                      ),
                      Text(
                        '${(_progress * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.deepRose,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 10,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.deepRose,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$_completedCount of ${_habits.length} little habits completed',
                    style: const TextStyle(
                      color: AppTheme.softBrown,
                      fontSize: 13,
                    ),
                  ),
                  if (_habits.isNotEmpty && _completedCount == _habits.length)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'You did it! Be proud of yourself 💗',
                        style: TextStyle(
                          color: AppTheme.deepRose,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 26),

            const Text(
              "Today's self-care list",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 12),

            // Interactive habit checklist
            if (_habits.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  'Your list is empty. Add a little habit below 🌼',
                  style: TextStyle(color: AppTheme.softBrown),
                ),
              ),

            ..._habits.asMap().entries.map((entry) {
              final index = entry.key;
              final habit = entry.value;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.blushPink.withValues(alpha: 0.45),
                  ),
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  clipBehavior: Clip.antiAlias,
                  child: CheckboxListTile(
                    value: habit.isDone,
                    onChanged: (value) {
                      setState(() {
                        _habits[index].isDone = value ?? false;
                      });
                    },
                    activeColor: AppTheme.deepRose,
                    controlAffinity: ListTileControlAffinity.leading,
                    secondary: Icon(
                      habit.icon,
                      color: AppTheme.deepRose,
                      size: 24,
                    ),
                    title: Text(
                      habit.title,
                      style: TextStyle(
                        color: AppTheme.softBrown,
                        fontSize: 14,
                        decoration: habit.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 18),
            const Text(
              'Add a little habit',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepRose,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _habitController,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _addHabit(),
                    decoration: InputDecoration(
                      hintText: 'e.g. Read for 10 minutes',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppTheme.blushPink.withValues(alpha: 0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppTheme.blushPink.withValues(alpha: 0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppTheme.deepRose),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filled(
                  onPressed: _addHabit,
                  tooltip: 'Add habit',
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.deepRose,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                  ),
                  icon: const Icon(Icons.add_rounded),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Center(
              child: Text(
                'Remember: progress, not perfection 🌸',
                textAlign: TextAlign.center,
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

class _Habit {
  _Habit(this.title, this.icon);

  final String title;
  final IconData icon;
  bool isDone = false;
}
