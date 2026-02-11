import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[400]!, Colors.blue[900]!],
            ),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '📚',
              style: TextStyle(fontSize: 36),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Formula Master',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Учите формулы с удовольствием',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400]!,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}