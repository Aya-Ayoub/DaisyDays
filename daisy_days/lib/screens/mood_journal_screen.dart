import 'package:flutter/material.dart';

import '../app_theme.dart';

class MoodJournalScreen extends StatelessWidget {
  const MoodJournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_rounded, size: 56, color: AppTheme.deepRose),
              SizedBox(height: 16),
              Text(
                'My Mood Journal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepRose,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your mood journal will be built here.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.softBrown),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
