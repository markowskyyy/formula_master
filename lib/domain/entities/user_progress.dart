class TestResult {
  final String testId;
  final double scorePercentage;
  final int correctAnswers;
  final int totalQuestions;
  final int pointsEarned;
  final DateTime completedAt;

  TestResult({
    required this.testId,
    required this.scorePercentage,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.pointsEarned,
    required this.completedAt,
  });
}

class UserProgress {
  final int completedTests;
  final double averageScore;
  final int totalPoints;
  final Map<String, TestResult> testResults;
  final DateTime lastActivity;

  UserProgress({
    required this.completedTests,
    required this.averageScore,
    required this.totalPoints,
    required this.testResults,
    required this.lastActivity,
  });
}
class QuizResult {
  final String quizId;
  final bool isCorrect;
  final int attempts;
  final DateTime lastAttempt;

  QuizResult({
    required this.quizId,
    required this.isCorrect,
    required this.attempts,
    required this.lastAttempt,
  });
}


// class UserProgress {
//   final int completedTests;
//   final double averageScore;
//   final Map<String, TestResult> testResults;
//   final DateTime lastActivity;
//
//   UserProgress({
//     required this.completedTests,
//     required this.averageScore,
//     required this.testResults,
//     required this.lastActivity,
//   });
// }