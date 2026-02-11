import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final int size;
  const Gap(
      this.size,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.toDouble(),
      height: size.toDouble(),
    );
  }
}
