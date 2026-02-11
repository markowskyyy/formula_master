import 'package:flutter/material.dart';
import 'package:formula_master/domain/entities/test.dart';
import 'package:formula_master/presentation/ui_kit/special/difficulty_badge.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';


class TestCard extends StatelessWidget {
  final Test test;

  const TestCard({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    test.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (test.isLocked) ...[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              test.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SubjectTag(subject: test.subject),
                const SizedBox(width: 8),
                DifficultyBadge(difficulty: test.difficulty),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${test.questionCount} вопросов',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (!test.isLocked)
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Начать тест'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}