import 'package:flutter/material.dart';

import '../app_theme.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.spa_rounded, size: 56, color: AppTheme.deepRose),
              SizedBox(height: 16),
              Text(
                'Your Little Habits',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepRose,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your habit tracker will be built here.',
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
