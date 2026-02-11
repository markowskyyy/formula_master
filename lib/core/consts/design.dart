import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color.fromRGBO(15, 23, 42, 1);
  static const Color textFieldBackground = Color.fromRGBO(20, 41, 68, 1);
  static const Color line = Color.fromRGBO(31, 58, 95, 1);
  static const Color lineLight = Color.fromRGBO(46, 74, 111, 1);
  static const Color blue = Color.fromRGBO(74, 158, 255, 1);
  static const Color white = Colors.white;
  static const Color darkText = Color(0xFF333333);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color red = Color(0xFFEF5350);
}

class AppTextStyles {
  static const String fontFamily = 'Nunito';

  // Заголовки
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Основной текст
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );

  // Кнопки
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle buttonLight = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Цифры/статистика
  static const TextStyle statNumber = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle statLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
  );
}