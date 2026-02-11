import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/presentation/providers/progress_provider.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(userProgressProvider);
    final achievementsCount = ref.watch(unlockedAchievementsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            StatsSummary(
              completedTests: progress.completedTests,
              averageScore: progress.averageScore,
              totalPoints: progress.totalPoints,
              achievementsCount: achievementsCount,
            ),
            const SizedBox(height: 32),
            const AboutSection(),
            const SizedBox(height: 24),
            const ResetProgressButton(),
            const SizedBox(height: 32),
            const VersionInfo(),
          ],
        ),
      ),
    );
  }
}