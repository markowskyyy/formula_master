import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';

class StatsSummary extends StatelessWidget {
  final int completedTests;
  final double averageScore;
  final int totalPoints;
  final int achievementsCount;

  const StatsSummary({
    super.key,
    required this.completedTests,
    required this.averageScore,
    required this.totalPoints,
    required this.achievementsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ваша статистика',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[300]!,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: completedTests.toString(),
                label: 'Тестов',
                icon: Icons.assignment,
                color: Colors.blue,
              ),
              _StatItem(
                value: '${averageScore.round()}%',
                label: 'Средний балл',
                icon: Icons.percent,
                color: Colors.green,
              ),
              _StatItem(
                value: totalPoints.toString(),
                label: 'Баллов',
                icon: Icons.stars,
                color: Colors.orange,
              ),
              _StatItem(
                value: achievementsCount.toString(),
                label: 'Очивок',
                icon: Icons.emoji_events,
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}