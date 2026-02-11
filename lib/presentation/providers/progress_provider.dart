import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/domain/entities/user_progress.dart';


class UserProgressNotifier extends StateNotifier<UserProgress> {
  UserProgressNotifier() : super(_initialProgress);

  static final UserProgress _initialProgress = UserProgress(
    completedTests: 0,
    averageScore: 0,
    totalPoints: 0,
    testResults: {},
    lastActivity: DateTime.now(),
  );

  // Обновить результат теста
  void updateTestResult(TestResult result) {
    final updatedResults = Map<String, TestResult>.from(state.testResults);
    updatedResults[result.testId] = result;

    // Пересчитываем общие баллы
    final totalPoints = updatedResults.values.fold<int>(
      0,
          (sum, r) => sum + r.pointsEarned,
    );

    // Пересчитываем средний балл
    final totalScore = updatedResults.values.fold<double>(
      0,
          (sum, r) => sum + r.scorePercentage,
    );
    final averageScore = updatedResults.isEmpty ? 0 : totalScore / updatedResults.length;

    state = UserProgress(
      completedTests: state.completedTests + 1,
      averageScore: averageScore.toDouble(),
      totalPoints: totalPoints,
      testResults: updatedResults,
      lastActivity: DateTime.now(),
    );
  }

  // Сбросить прогресс
  void resetProgress() {
    state = UserProgress(
      completedTests: 0,
      averageScore: 0,
      totalPoints: 0,
      testResults: {},
      lastActivity: DateTime.now(),
    );
  }

  // Получить количество полученных очивок
  int getUnlockedAchievementsCount() {
    final tests = state.completedTests;
    int count = 0;
    if (tests >= 3) count++;
    if (tests >= 10) count++;
    if (tests >= 15) count++;
    return count;
  }

  // Проверить, получена ли конкретная очивка
  bool isAchievementUnlocked(int targetTests) {
    return state.completedTests >= targetTests;
  }
}

final userProgressProvider = StateNotifierProvider<UserProgressNotifier, UserProgress>((ref) {
  return UserProgressNotifier();
});

final unlockedAchievementsCountProvider = Provider<int>((ref) {
  final notifier = ref.watch(userProgressProvider.notifier);
  return notifier.getUnlockedAchievementsCount();
});

final achievementUnlockedProvider = Provider.family<bool, int>((ref, targetTests) {
  final notifier = ref.watch(userProgressProvider.notifier);
  return notifier.isAchievementUnlocked(targetTests);
});

final latestTestResultsProvider = Provider<List<TestResult>>((ref) {
  final progress = ref.watch(userProgressProvider);
  final results = progress.testResults.values.toList();
  results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
  return results.take(5).toList();
});