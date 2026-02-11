import 'package:flutter/material.dart';
import 'package:formula_master/domain/entities/formula.dart';


class DifficultyBadge extends StatelessWidget {
  final Difficulty difficulty;

  const DifficultyBadge({super.key, required this.difficulty});

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
    switch (difficulty) {
      case Difficulty.easy:
        return Colors.green;
      case Difficulty.medium:
        return Colors.orange;
      case Difficulty.hard:
        return Colors.red;
    }
  }

  String _getName() {
    switch (difficulty) {
      case Difficulty.easy:
        return 'Лёгкий';
      case Difficulty.medium:
        return 'Средний';
      case Difficulty.hard:
        return 'Сложный';
    }
  }
}