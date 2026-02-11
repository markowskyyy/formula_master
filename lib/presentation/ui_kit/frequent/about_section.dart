import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Formula Master',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Изучайте формулы по физике, математике и химии в интерактивном формате. Проходите тесты, зарабатывайте баллы и открывайте достижения!',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class VersionInfo extends StatelessWidget {
  final String version;

  const VersionInfo({
    super.key,
    this.version = '1.0.0',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Formula Master v$version',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}