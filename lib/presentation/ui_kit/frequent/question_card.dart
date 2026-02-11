import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';
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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.line,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
          // if (latexExpression.isNotEmpty) ...[
          //   const SizedBox(height: 16),
          //   Container(
          //     width: double.infinity,
          //     padding: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       color: AppColors.textFieldBackground,
          //       borderRadius: BorderRadius.circular(12),
          //         border: Border.all(
          //           color: AppColors.lineLight,
          //         )
          //     ),
          //     child: LatexRenderer(expression: latexExpression, black: false),
          //   ),
          // ],
        ],
      ),
    );
  }
}