import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/domain/entities/user_progress.dart';
import 'package:formula_master/presentation/providers/progress_provider.dart';
import 'package:formula_master/presentation/providers/test_provider.dart';

// ViewModel для управления логикой теста
class TestViewModel extends StateNotifier<TestSession?> {
  final Ref ref;

  TestViewModel(this.ref) : super(null);

  // Инициализация теста
  void initTest(String testId) {
    ref.read(testSessionProvider.notifier).state = TestSession(
      testId: testId,
      userAnswers: [],
      currentQuestionIndex: 0,
      startTime: DateTime.now(),
    );
  }

  // Получить текущую сессию
  TestSession? get session => ref.read(testSessionProvider);

  // Проверка ответа
  bool checkAnswer(int selectedIndex, int correctIndex) {
    return selectedIndex == correctIndex;
  }

  // Переход к следующему вопросу
  void nextQuestion(int selectedAnswer) {
    final currentSession = ref.read(testSessionProvider);
    if (currentSession == null) return;

    final updatedAnswers = List<int>.from(currentSession.userAnswers)
      ..add(selectedAnswer);

    ref.read(testSessionProvider.notifier).state = currentSession.copyWith(
      userAnswers: updatedAnswers,
      currentQuestionIndex: currentSession.currentQuestionIndex + 1,
    );
  }

  Future<void> completeTest(int selectedAnswer) async {
    final currentSession = ref.read(testSessionProvider);
    if (currentSession == null) return;

    final test = ref.read(testByIdProvider(currentSession.testId));
    if (test == null) return;

    final allAnswers = List<int>.from(currentSession.userAnswers);

    if (allAnswers.length < test.questions.length) {
      allAnswers.add(selectedAnswer);
    }

    print('📊 Тест: ${test.title}');
    print('📝 Всего вопросов: ${test.questions.length}');
    print('✅ Ответы пользователя: ${allAnswers}');
    print('🎯 Правильные ответы: ${test.questions.map((q) => q.correctAnswerIndex).toList()}');

    int correctCount = 0;
    for (int i = 0; i < test.questions.length; i++) {
      final isCorrect = i < allAnswers.length &&
          allAnswers[i] == test.questions[i].correctAnswerIndex;
      print('  Вопрос ${i+1}: выбрал ${allAnswers[i]}, правильно ${test.questions[i].correctAnswerIndex} -> ${isCorrect ? '✅' : '❌'}');
      if (isCorrect) correctCount++;
    }
    print('🎯 Итого правильно: $correctCount/${test.questions.length}');

    final percentage = (correctCount / test.questions.length * 100);
    final pointsEarned = (percentage / 10).round();

    final testResult = TestResult(
      testId: currentSession.testId,
      scorePercentage: percentage,
      correctAnswers: correctCount,
      totalQuestions: test.questions.length,
      pointsEarned: pointsEarned,
      completedAt: DateTime.now(),
    );

    ref.read(userProgressProvider.notifier).updateTestResult(testResult);

    ref.read(testSessionProvider.notifier).state = currentSession.copyWith(
      userAnswers: allAnswers,
      isCompleted: true,
    );
  }


  void resetSession() {
    ref.read(testSessionProvider.notifier).state = null;
  }

  // Получение результатов теста для диалога
  Map<String, dynamic> getTestResults() {
    final session = ref.read(testSessionProvider);
    if (session == null || !session.isCompleted) return {};

    final test = ref.read(testByIdProvider(session.testId));
    if (test == null) return {};

    int correctCount = 0;
    for (int i = 0; i < test.questions.length; i++) {
      if (i < session.userAnswers.length &&
          session.userAnswers[i] == test.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    final percentage = (correctCount / test.questions.length * 100).round();
    final pointsEarned = (percentage / 10).round();

    return {
      'correctCount': correctCount,
      'totalCount': test.questions.length,
      'percentage': percentage,
      'pointsEarned': pointsEarned,
    };
  }

  // Является ли текущий вопрос последним
  bool isLastQuestion() {
    final session = ref.read(testSessionProvider);
    if (session == null) return false;

    final test = ref.read(testByIdProvider(session.testId));
    if (test == null) return false;

    return session.currentQuestionIndex + 1 >= test.questions.length;
  }
}

// Провайдер ViewModel
final testViewModelProvider = StateNotifierProvider<TestViewModel, TestSession?>(
      (ref) => TestViewModel(ref),
);

// Провайдер результатов теста (для диалога)
final testResultsProvider = Provider<Map<String, dynamic>>((ref) {
  final viewModel = ref.watch(testViewModelProvider.notifier);
  return viewModel.getTestResults();
});

// Провайдер для проверки последнего вопроса
final isLastQuestionProvider = Provider<bool>((ref) {
  final viewModel = ref.watch(testViewModelProvider.notifier);
  return viewModel.isLastQuestion();
});