import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/habits_screen.dart';
import 'screens/mood_journal_screen.dart';

void main() {
  runApp(const DaisyDaysApp());
}

class DaisyDaysApp extends StatelessWidget {
  const DaisyDaysApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daisy Days',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DaisyDaysNavigation(),
    );
  }
}

class DaisyDaysNavigation extends StatefulWidget {
  const DaisyDaysNavigation({super.key});

  @override
  State<DaisyDaysNavigation> createState() => _DaisyDaysNavigationState();
}

class _DaisyDaysNavigationState extends State<DaisyDaysNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    HabitsScreen(),
    MoodJournalScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.spa_outlined),
            selectedIcon: Icon(Icons.spa_rounded),
            label: 'Habits',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'My Mood',
          ),
        ],
      ),
    );
  }
}
