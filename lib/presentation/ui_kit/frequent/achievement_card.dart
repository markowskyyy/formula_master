import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final int currentValue;
  final int targetValue;
  final IconData icon;
  final Color color;

  const AchievementCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentValue,
    required this.targetValue,
    required this.icon,
    required this.color,
  });

  bool get _isUnlocked => currentValue >= targetValue;
  double get _progress => (currentValue / targetValue).clamp(0, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground.withAlpha(100),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isUnlocked ? color.withOpacity(0.3) : AppColors.lineLight,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isUnlocked ? color.withOpacity(0.1) : AppColors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _isUnlocked ? icon : Icons.lock_outline,
              color: _isUnlocked ? color : Colors.grey[400],
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    if (_isUnlocked) ...[
                      const SizedBox(width: 8),
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green[600],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isUnlocked ? color : AppColors.blue,
                    ),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _isUnlocked
                      ? 'Получено!'
                      : '${currentValue}/${targetValue}',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isUnlocked ? color : Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}