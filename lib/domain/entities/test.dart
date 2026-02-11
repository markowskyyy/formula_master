import 'package:formula_master/domain/entities/formula.dart';
import 'package:formula_master/domain/entities/test_question.dart';

class Test {
  final String id;
  final String title;
  final String description;
  final Subject subject;
  final Difficulty difficulty;
  final List<TestQuestion> questions;
  final int timeLimitMinutes;
  final int passingScore;
  final bool isLocked;
  final double? bestResult;

  Test({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.difficulty,
    required this.questions,
    required this.timeLimitMinutes,
    required this.passingScore,
    this.isLocked = false,
    this.bestResult,
  });

  int get questionCount => questions.length;

  Test copyWith({
    String? id,
    String? title,
    String? description,
    Subject? subject,
    Difficulty? difficulty,
    List<TestQuestion>? questions,
    int? timeLimitMinutes,
    int? passingScore,
    bool? isLocked,
    double? bestResult,
  }) {
    return Test(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      difficulty: difficulty ?? this.difficulty,
      questions: questions ?? this.questions,
      timeLimitMinutes: timeLimitMinutes ?? this.timeLimitMinutes,
      passingScore: passingScore ?? this.passingScore,
      isLocked: isLocked ?? this.isLocked,
      bestResult: bestResult ?? this.bestResult,
    );
  }
}