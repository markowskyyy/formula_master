import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/domain/entities/user_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kProgressKey = 'user_progress';

class UserProgressNotifier extends StateNotifier<UserProgress> {
  UserProgressNotifier() : super(_initialProgress) {
    _loadProgress();
  }

  static final UserProgress _initialProgress = UserProgress(
    completedTests: 0,
    averageScore: 0,
    totalPoints: 0,
    testResults: {},
    lastActivity: DateTime.now(),
  );

  // Загрузка прогресса из SharedPreferences
  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? progressJson = prefs.getString(_kProgressKey);

      if (progressJson != null) {
        final Map<String, dynamic> json = jsonDecode(progressJson);

        // Восстанавливаем testResults
        final Map<String, TestResult> testResults = {};
        final resultsJson = json['testResults'] as Map<String, dynamic>? ?? {};

        resultsJson.forEach((key, value) {
          testResults[key] = TestResult(
            testId: value['testId'],
            scorePercentage: value['scorePercentage'].toDouble(),
            correctAnswers: value['correctAnswers'],
            totalQuestions: value['totalQuestions'],
            pointsEarned: value['pointsEarned'],
            completedAt: DateTime.parse(value['completedAt']),
          );
        });

        state = UserProgress(
          completedTests: json['completedTests'] ?? 0,
          averageScore: (json['averageScore'] ?? 0).toDouble(),
          totalPoints: json['totalPoints'] ?? 0,
          testResults: testResults,
          lastActivity: DateTime.parse(json['lastActivity'] ?? DateTime.now().toIso8601String()),
        );
      }
    } catch (e) {
      print('Ошибка загрузки прогресса: $e');
    }
  }

  // Сохранение прогресса в SharedPreferences
  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Преобразуем testResults в JSON
      final Map<String, dynamic> resultsJson = {};
      state.testResults.forEach((key, result) {
        resultsJson[key] = {
          'testId': result.testId,
          'scorePercentage': result.scorePercentage,
          'correctAnswers': result.correctAnswers,
          'totalQuestions': result.totalQuestions,
          'pointsEarned': result.pointsEarned,
          'completedAt': result.completedAt.toIso8601String(),
        };
      });

      final progressJson = jsonEncode({
        'completedTests': state.completedTests,
        'averageScore': state.averageScore,
        'totalPoints': state.totalPoints,
        'testResults': resultsJson,
        'lastActivity': state.lastActivity.toIso8601String(),
      });

      await prefs.setString(_kProgressKey, progressJson);
    } catch (e) {
      print('Ошибка сохранения прогресса: $e');
    }
  }

  // Обновить результат теста
  Future<void> updateTestResult(TestResult result) async {
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
      completedTests: updatedResults.length, // Количество уникальных пройденных тестов
      averageScore: averageScore.toDouble(),
      totalPoints: totalPoints,
      testResults: updatedResults,
      lastActivity: DateTime.now(),
    );

    await _saveProgress();
  }

  // Сбросить прогресс
  Future<void> resetProgress() async {
    state = UserProgress(
      completedTests: 0,
      averageScore: 0,
      totalPoints: 0,
      testResults: {},
      lastActivity: DateTime.now(),
    );
    await _saveProgress();
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

  // Получить результат конкретного теста
  TestResult? getTestResult(String testId) {
    return state.testResults[testId];
  }

  // Получить лучший результат теста
  double? getBestResult(String testId) {
    final result = state.testResults[testId];
    return result?.scorePercentage;
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

// Провайдер для получения результата конкретного теста
final testResultByIdProvider = Provider.family<TestResult?, String>((ref, testId) {
  final notifier = ref.watch(userProgressProvider.notifier);
  return notifier.getTestResult(testId);
});

// Провайдер для лучшего результата теста
final bestResultProvider = Provider.family<double?, String>((ref, testId) {
  final notifier = ref.watch(userProgressProvider.notifier);
  return notifier.getBestResult(testId);
});