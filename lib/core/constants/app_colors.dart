import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0B1020);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceElevated = Color(0xFF1A2235);
  static const Color accent = Color(0xFF4F46E5);
  static const Color accentSecondary = Color(0xFF06B6D4);
  static const Color accentGlow = Color(0x334F46E5);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF475569);
  static const Color border = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFF2D3748);
  static const Color white = Color(0xFFFFFFFF);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B1020), Color(0xFF0F172A), Color(0xFF0B1020)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentSecondary],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2235), Color(0xFF111827)],
  );
}
