import 'package:flutter/material.dart';

import '../app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _dailyTasks = [
    'Drink a glass of water',
    'Take a little screen break',
    'Spend time on myself',
  ];

  final List<bool> _completedTasks = [false, false, false];

  int get _completedCount =>
      _completedTasks.where((completed) => completed).length;

  @override
  Widget build(BuildContext context) {
    final double progress = _completedCount / _dailyTasks.length;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            const SizedBox(height: 28),
            const Text(
              'A little space just for you 🌷',
              style: TextStyle(color: AppTheme.softBrown, fontSize: 14),
            ),
            const SizedBox(height: 7),
            const Text(
              'Hello, lovely!',
              style: TextStyle(
                color: AppTheme.deepRose,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 22),
            _buildProgressCard(progress),
            const SizedBox(height: 28),
            _buildSectionHeading('Your little goals', 'Small steps count'),
            const SizedBox(height: 14),
            _buildTaskList(),
            const SizedBox(height: 24),
            _buildQuoteCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppTheme.palePink,
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.local_florist_rounded,
            color: AppTheme.deepRose,
            size: 27,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DAISY DAYS',
                style: TextStyle(
                  color: AppTheme.deepRose,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Your daily dose of self-care',
                style: TextStyle(color: AppTheme.softBrown, fontSize: 11),
              ),
            ],
          ),
        ),
        const Icon(Icons.wb_sunny_outlined, color: AppTheme.deepRose, size: 25),
      ],
    );
  }

  Widget _buildProgressCard(double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF9DCE5), Color(0xFFFFEEF2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Today is yours to bloom',
                  style: TextStyle(
                    color: AppTheme.deepRose,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.local_florist_rounded,
                color: AppTheme.deepRose,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            'You have completed $_completedCount '
            'of ${_dailyTasks.length} little rituals.',
            style: const TextStyle(color: AppTheme.softBrown, fontSize: 13),
          ),
          const SizedBox(height: 17),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              color: AppTheme.deepRose,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            '${(progress * 100).round()}% of your daily rituals complete',
            style: const TextStyle(
              color: AppTheme.deepRose,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppTheme.softBrown,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: AppTheme.deepRose, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: List.generate(_dailyTasks.length, (index) {
            final bool isCompleted = _completedTasks[index];

            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: IconButton(
                    tooltip: isCompleted
                        ? 'Mark as incomplete'
                        : 'Mark as complete',
                    onPressed: () {
                      setState(() {
                        _completedTasks[index] = !isCompleted;
                      });
                    },
                    icon: Icon(
                      isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isCompleted
                          ? AppTheme.deepRose
                          : AppTheme.blushPink,
                      size: 27,
                    ),
                  ),
                  title: Text(
                    _dailyTasks[index],
                    style: TextStyle(
                      color: AppTheme.softBrown,
                      fontSize: 13,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.blushPink,
                  ),
                  onTap: () {
                    setState(() {
                      _completedTasks[index] = !isCompleted;
                    });
                  },
                ),
                if (index != _dailyTasks.length - 1)
                  const Divider(height: 1, color: AppTheme.palePink),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildQuoteCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EAE4),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.favorite_rounded, color: AppTheme.deepRose, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A gentle reminder',
                  style: TextStyle(
                    color: AppTheme.deepRose,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'You do not have to do everything today. '
                  'Taking care of yourself is enough.',
                  style: TextStyle(
                    color: AppTheme.softBrown,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
