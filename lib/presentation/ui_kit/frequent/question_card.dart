import 'package:flutter/material.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String latexExpression;

  const QuestionCard({
    super.key,
    required this.question,
    required this.latexExpression,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (latexExpression.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: LatexRenderer(expression: latexExpression),
            ),
          ],
        ],
      ),
    );
  }
}