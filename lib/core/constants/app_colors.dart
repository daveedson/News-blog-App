import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentBlue = Color(0xFF3D8BFF);
  static const Color backgroundGrey = Color(0xFFF2F2F7);
  static const Color titleDark = Color(0xFF1A1A2E);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accent, accentBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
