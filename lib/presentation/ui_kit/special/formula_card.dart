import 'package:flutter/material.dart';
import 'package:formula_master/domain/entities/formula.dart';


class FormulaCard extends StatelessWidget {
  final Formula formula;

  const FormulaCard({super.key, required this.formula});

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
                    formula.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SubjectTag(subject: formula.subject),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              formula.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: LatexRenderer(expression: formula.latexExpression),
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

  const LatexRenderer({super.key, required this.expression});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        expression,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
