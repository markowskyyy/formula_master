import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/presentation/providers/progress_provider.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    final completedTests = progress.completedTests;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Достижения'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '${progress.completedTests} тестов пройдено',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Очивки',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AchievementCard(
              title: 'Новичок',
              description: 'Пройдите 3 теста',
              currentValue: completedTests,
              targetValue: 3,
              icon: Icons.school,
              color: Colors.brown,
            ),
            const SizedBox(height: 12),
            AchievementCard(
              title: 'Любознательный',
              description: 'Пройдите 10 тестов',
              currentValue: completedTests,
              targetValue: 10,
              icon: Icons.menu_book,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            AchievementCard(
              title: 'Знаток формул',
              description: 'Пройдите 15 тестов',
              currentValue: completedTests,
              targetValue: 15,
              icon: Icons.emoji_events,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}