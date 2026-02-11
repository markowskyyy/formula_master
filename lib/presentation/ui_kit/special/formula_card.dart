import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';
import 'package:formula_master/domain/entities/formula.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';


class FormulaCard extends StatelessWidget {
  final Formula formula;

  const FormulaCard({super.key, required this.formula});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    formula.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                const Gap(12),
                SubjectTag(subject: formula.subject),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formula.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.textFieldBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lineLight, width: 1)
              ),
              child: LatexRenderer(expression: formula.latexExpression, black: false),
            ),
          ],
        ),
      ),
    );
  }
}



class SubjectTag extends StatelessWidget {
  final Subject subject;

  const SubjectTag({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor().withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getName(),
        style: TextStyle(
          color: _getColor(),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getColor() {
    switch (subject) {
      case Subject.mathematics:
        return Colors.blue;
      case Subject.physics:
        return Colors.green;
      case Subject.chemistry:
        return Colors.orange;
    }
  }

  String _getName() {
    switch (subject) {
      case Subject.mathematics:
        return 'Математика';
      case Subject.physics:
        return 'Физика';
      case Subject.chemistry:
        return 'Химия';
    }
  }
}


class LatexRenderer extends StatelessWidget {
  final String expression;
  final bool black;

  const LatexRenderer({super.key, required this.expression, required this.black});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        expression,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w500,
          color: black ? Colors.black : Colors.white
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
