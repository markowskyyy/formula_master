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

class UserProgress {
  final int totalPoints;
  final int weeklyPoints;
  final double averageScore;
  final double monthlyScoreIncrease;
  final int rank;
  final int rankChange;
  final int currentStreak;
  final int bestStreak;
  final int completedTests;
  final Map<String, TestResult> testResults;
  final Map<String, QuizResult> quizResults;
  final DateTime lastActivity;

  UserProgress({
    required this.totalPoints,
    required this.weeklyPoints,
    required this.averageScore,
    required this.monthlyScoreIncrease,
    required this.rank,
    required this.rankChange,
    required this.currentStreak,
    required this.bestStreak,
    required this.completedTests,
    required this.testResults,
    required this.quizResults,
    required this.lastActivity,
  });
}