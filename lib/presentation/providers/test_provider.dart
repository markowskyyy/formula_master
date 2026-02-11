import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/data/local/local_tests_data.dart';
import 'package:formula_master/domain/entities/formula.dart';
import 'package:formula_master/domain/entities/test.dart';
import 'package:formula_master/domain/entities/test_question.dart';

// Провайдер для списка всех тестов
final testListProvider = Provider<List<Test>>((ref) {
  return mockTests;
});

// Провайдер для фильтрации тестов по предмету
final testFilterProvider = StateProvider<Subject?>((ref) => null);

// Отфильтрованный список тестов
final filteredTestListProvider = Provider<List<Test>>((ref) {
  final tests = ref.watch(testListProvider);
  final filter = ref.watch(testFilterProvider);

  if (filter == null) return tests;
  return tests.where((t) => t.subject == filter).toList();
});

// Провайдер для поиска по тестам
final testSearchQueryProvider = StateProvider<String>((ref) => '');

// Поиск по тестам
final searchedTestListProvider = Provider<List<Test>>((ref) {
  final tests = ref.watch(filteredTestListProvider);
  final query = ref.watch(testSearchQueryProvider);

  if (query.isEmpty) return tests;

  return tests.where((t) {
    final title = t.title.toLowerCase();
    final description = t.description.toLowerCase();
    final search = query.toLowerCase();
    return title.contains(search) || description.contains(search);
  }).toList();
});

// Провайдер для конкретного теста по ID
final testByIdProvider = Provider.family<Test?, String>((ref, id) {
  final tests = ref.watch(testListProvider);
  try {
    return tests.firstWhere((t) => t.id == id);
  } catch (e) {
    return null;
  }
});

// Провайдер для тестов по предмету
final testsBySubjectProvider = Provider.family<List<Test>, Subject>((ref, subject) {
  final tests = ref.watch(testListProvider);
  return tests.where((t) => t.subject == subject).toList();
});

// Провайдер для доступных тестов (не заблокированных)
final availableTestsProvider = Provider<List<Test>>((ref) {
  final tests = ref.watch(testListProvider);
  return tests.where((t) => !t.isLocked).toList();
});

// Провайдер для тестов по сложности
final testsByDifficultyProvider = Provider.family<List<Test>, Difficulty>((ref, difficulty) {
  final tests = ref.watch(testListProvider);
  return tests.where((t) => t.difficulty == difficulty).toList();
});

// Провайдер для состояния текущего прохождения теста
class TestSession {
  final String testId;
  final List<int> userAnswers;
  final int currentQuestionIndex;
  final DateTime startTime;
  final bool isCompleted;

  TestSession({
    required this.testId,
    required this.userAnswers,
    required this.currentQuestionIndex,
    required this.startTime,
    this.isCompleted = false,
  });

  TestSession copyWith({
    String? testId,
    List<int>? userAnswers,
    int? currentQuestionIndex,
    DateTime? startTime,
    bool? isCompleted,
  }) {
    return TestSession(
      testId: testId ?? this.testId,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      startTime: startTime ?? this.startTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

final testSessionProvider = StateProvider<TestSession?>((ref) => null);

// Провайдер для текущего вопроса
final currentQuestionProvider = Provider<TestQuestion?>((ref) {
  final session = ref.watch(testSessionProvider);
  final test = session != null
      ? ref.watch(testByIdProvider(session.testId))
      : null;

  if (session == null || test == null) return null;
  if (session.currentQuestionIndex >= test.questions.length) return null;

  return test.questions[session.currentQuestionIndex];
});

// Провайдер для прогресса теста
final testProgressProvider = Provider<double>((ref) {
  final session = ref.watch(testSessionProvider);
  final test = session != null
      ? ref.watch(testByIdProvider(session.testId))
      : null;

  if (session == null || test == null) return 0;
  return session.currentQuestionIndex / test.questions.length;
});

// Провайдер для результата теста
final testResultProvider = Provider<int?>((ref) {
  final session = ref.watch(testSessionProvider);
  final test = session != null
      ? ref.watch(testByIdProvider(session.testId))
      : null;

  if (session == null || test == null || !session.isCompleted) return null;

  int correctCount = 0;
  for (int i = 0; i < test.questions.length; i++) {
    if (i < session.userAnswers.length &&
        session.userAnswers[i] == test.questions[i].correctAnswerIndex) {
      correctCount++;
    }
  }

  return (correctCount / test.questions.length * 100).round();
});