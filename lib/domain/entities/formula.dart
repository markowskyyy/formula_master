enum Subject { mathematics, physics, chemistry }
enum Difficulty { easy, medium, hard }

class Formula {
  final String id;
  final String title;
  final String description;
  final String latexExpression;
  final Subject subject;
  final Difficulty difficulty;

  Formula({
    required this.id,
    required this.title,
    required this.description,
    required this.latexExpression,
    required this.subject,
    required this.difficulty,
  });

  Formula copyWith({
    String? id,
    String? title,
    String? description,
    String? latexExpression,
    Subject? subject,
    Difficulty? difficulty,
  }) {
    return Formula(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latexExpression: latexExpression ?? this.latexExpression,
      subject: subject ?? this.subject,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}