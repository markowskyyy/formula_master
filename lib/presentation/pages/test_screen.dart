import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/domain/entities/test_question.dart';
import 'package:formula_master/presentation/providers/formula_provider.dart';
import 'package:formula_master/presentation/providers/test_provider.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';



class TestScreen extends ConsumerStatefulWidget {
  final String testId;

  const TestScreen({super.key, required this.testId});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  int? selectedAnswerIndex;
  bool showResult = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    // Инициализируем сессию теста
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(testSessionProvider.notifier).state = TestSession(
        testId: widget.testId,
        userAnswers: [],
        currentQuestionIndex: 0,
        startTime: DateTime.now(),
      );
    });
  }

  @override
  void dispose() {
    // Очищаем сессию при выходе
    ref.read(testSessionProvider.notifier).state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(testSessionProvider);
    final test = ref.watch(testByIdProvider(widget.testId));
    final currentQuestion = ref.watch(currentQuestionProvider);
    final progress = ref.watch(testProgressProvider);

    if (test == null || session == null || currentQuestion == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(test.title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // TODO: Показать диалог подтверждения выхода
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          ProgressBar(
            current: session.currentQuestionIndex + 1,
            total: test.questions.length,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionCard(
                    question: currentQuestion.question,
                    latexExpression: _getFormulaById(currentQuestion.formulaId),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Выберите ответ:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    currentQuestion.options.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnswerButton(
                        text: currentQuestion.options[index],
                        index: index,
                        isSelected: selectedAnswerIndex == index,
                        isCorrect: showResult ? index == currentQuestion.correctAnswerIndex : null,
                        isWrong: showResult && selectedAnswerIndex == index && index != currentQuestion.correctAnswerIndex,
                        onTap: showResult
                            ? null
                            : () {
                          setState(() {
                            selectedAnswerIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                  if (showResult) ...[
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCorrect ? Colors.green : Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isCorrect ? Icons.check_circle : Icons.cancel,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isCorrect ? 'Правильно!' : 'Неправильно',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion.explanation,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  offset: const Offset(0, -4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: selectedAnswerIndex == null
                      ? null
                      : () => _handleAnswer(context, currentQuestion, session),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    showResult ? 'Следующий вопрос' : 'Проверить ответ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAnswer(BuildContext context, TestQuestion question, TestSession session) {
    if (!showResult) {
      // Проверяем ответ
      final correct = selectedAnswerIndex == question.correctAnswerIndex;
      setState(() {
        showResult = true;
        isCorrect = correct;
      });
    } else {
      // Переходим к следующему вопросу
      final isLastQuestion = session.currentQuestionIndex + 1 >=
          ref.read(testByIdProvider(widget.testId))!.questions.length;

      if (isLastQuestion) {
        // Последний вопрос - показываем результат
        _showResultDialog(context);
      } else {
        // Следующий вопрос
        final updatedAnswers = List<int>.from(session.userAnswers)..add(selectedAnswerIndex!);

        ref.read(testSessionProvider.notifier).state = session.copyWith(
          userAnswers: updatedAnswers,
          currentQuestionIndex: session.currentQuestionIndex + 1,
        );

        setState(() {
          selectedAnswerIndex = null;
          showResult = false;
          isCorrect = false;
        });
      }
    }
  }

  void _showResultDialog(BuildContext context) {
    final session = ref.read(testSessionProvider);
    final test = ref.read(testByIdProvider(widget.testId));

    if (session == null || test == null) return;

    final answers = List<int>.from(session.userAnswers)..add(selectedAnswerIndex!);

    int correctCount = 0;
    for (int i = 0; i < test.questions.length; i++) {
      if (i < answers.length && answers[i] == test.questions[i].correctAnswerIndex) {
        correctCount++;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultDialog(
        correctCount: correctCount,
        totalCount: test.questions.length,
        onClose: () {
          Navigator.pop(context); // закрываем диалог
          Navigator.pop(context); // возвращаемся на collection_screen
        },
      ),
    );
  }

  String _getFormulaById(String formulaId) {
    final formula = ref.read(formulaByIdProvider(formulaId));
    return formula?.latexExpression ?? '';
  }
}