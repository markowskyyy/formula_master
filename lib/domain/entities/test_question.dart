class TestQuestion {
  final String id;
  final String formulaId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  TestQuestion({
    required this.id,
    required this.formulaId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  TestQuestion copyWith({
    String? id,
    String? formulaId,
    String? question,
    List<String>? options,
    int? correctAnswerIndex,
    String? explanation,
  }) {
    return TestQuestion(
      id: id ?? this.id,
      formulaId: formulaId ?? this.formulaId,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      explanation: explanation ?? this.explanation,
    );
  }
}