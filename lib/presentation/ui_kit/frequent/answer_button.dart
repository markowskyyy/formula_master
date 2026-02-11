import 'package:flutter/material.dart';
import 'package:formula_master/core/consts/design.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final int index;
  final bool isSelected;
  final bool? isCorrect;
  final bool isWrong;
  final VoidCallback? onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.index,
    this.isSelected = false,
    this.isCorrect,
    this.isWrong = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.textFieldBackground;
    Color borderColor = AppColors.line;
    Color textColor = Colors.white;

    if (isCorrect == true) {
      backgroundColor = AppColors.textFieldBackground;
      borderColor = Colors.green;
      textColor = Colors.green;
    } else if (isWrong) {
      backgroundColor = AppColors.textFieldBackground;
      borderColor = Colors.red;
      textColor = Colors.red;
    } else if (isSelected) {
      backgroundColor = AppColors.textFieldBackground;
      borderColor = Colors.blue;
      textColor = AppColors.blue;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected || isCorrect == true || isWrong
                    ? borderColor
                    : AppColors.line,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    color: isSelected || isCorrect == true || isWrong
                        ? Colors.white
                        : Colors.grey[100],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: isSelected || isCorrect == true || isWrong
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
            if (isCorrect == true)
              const Icon(Icons.check_circle, color: Colors.green),
            if (isWrong)
              const Icon(Icons.cancel, color: Colors.red),
          ],
        ),
      ),
    );
  }
}