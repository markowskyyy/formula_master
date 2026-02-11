import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';
import 'package:formula_master/domain/entities/test.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';
import 'package:go_router/go_router.dart';


class TestCard extends StatelessWidget {
  final Test test;

  const TestCard({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.line),
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
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
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
                    child: Icon(
                      Icons.lock,
                      size: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              test.description,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]
              )
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SubjectTag(subject: test.subject),
                const SizedBox(width: 8),
                DifficultyBadge(difficulty: test.difficulty),
                const SizedBox(width: 12),
                Icon(
                  Icons.help_outline,
                  size: 16,
                  color: AppColors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  '${test.questionCount}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!test.isLocked)
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('test', pathParameters: {'testId': test.id});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lineLight,
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