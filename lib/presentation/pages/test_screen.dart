import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/core/consts/design.dart';
import 'package:formula_master/domain/entities/test_question.dart';
import 'package:formula_master/presentation/providers/formula_provider.dart';
import 'package:formula_master/presentation/providers/test_provider.dart';
import 'package:formula_master/presentation/view_models/test_view_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(testViewModelProvider.notifier).initTest(widget.testId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(testSessionProvider);
    final test = ref.watch(testByIdProvider(widget.testId));
    final currentQuestion = ref.watch(currentQuestionProvider);
    final viewModel = ref.watch(testViewModelProvider.notifier);

    if (test == null || session == null || currentQuestion == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(test.title, style: AppTextStyles.title),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            viewModel.resetSession();
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
                      color: Colors.white,
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
                        isCorrect: showResult
                            ? index == currentQuestion.correctAnswerIndex
                            : null,
                        isWrong: showResult &&
                            selectedAnswerIndex == index &&
                            index != currentQuestion.correctAnswerIndex,
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
                    _buildExplanation(currentQuestion),
                  ],
                ],
              ),
            ),
          ),
          _buildBottomButton(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildExplanation(TestQuestion question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground,
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.explanation,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, TestViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!.withAlpha(25),
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
                : () => _handleAnswer(context, viewModel),
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
    );
  }

  void _handleAnswer(BuildContext context, TestViewModel viewModel) {
    final currentQuestion = ref.read(currentQuestionProvider);
    if (currentQuestion == null) return;

    if (!showResult) {
      final correct = viewModel.checkAnswer(
        selectedAnswerIndex!,
        currentQuestion.correctAnswerIndex,
      );
      setState(() {
        showResult = true;
        isCorrect = correct;
      });
    } else {
      if (viewModel.isLastQuestion()) {
        final session = ref.read(testSessionProvider);
        final test = ref.read(testByIdProvider(widget.testId));

        if (session != null && test != null) {
          final allAnswers = List<int>.from(session.userAnswers)
            ..add(selectedAnswerIndex!);

          int correctCount = 0;
          for (int i = 0; i < test.questions.length; i++) {
            if (i < allAnswers.length &&
                allAnswers[i] == test.questions[i].correctAnswerIndex) {
              correctCount++;
            }
          }
          viewModel.completeTest(selectedAnswerIndex!);
          _showResultDialog(context, correctCount, test.questions.length);
        }
      } else {
        viewModel.nextQuestion(selectedAnswerIndex!);
        setState(() {
          selectedAnswerIndex = null;
          showResult = false;
          isCorrect = false;
        });
      }
    }
  }

  void _showResultDialog(BuildContext context, int correctCount, int totalCount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ResultDialog(
        correctCount: correctCount,  // ← передаем сразу
        totalCount: totalCount,      // ← без провайдера
        onClose: () {
          ref.read(testViewModelProvider.notifier).resetSession();
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