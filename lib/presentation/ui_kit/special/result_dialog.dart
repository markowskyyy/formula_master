import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int correctCount;
  final int totalCount;
  final VoidCallback onClose;

  const ResultDialog({
    super.key,
    required this.correctCount,
    required this.totalCount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctCount / totalCount * 100).round();
    final isPassed = percentage >= 70;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isPassed ? Colors.green[50] : Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPassed ? Icons.emoji_events : Icons.rocket_launch,
                size: 48,
                color: isPassed ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPassed ? 'Тест завершён!' : 'Хорошая попытка!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Вы правильно ответили на $correctCount из $totalCount вопросов',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: isPassed ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}