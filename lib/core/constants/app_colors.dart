import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static bool _isDark = true;

  static void setMode(ThemeMode mode) {
    _isDark = mode != ThemeMode.light;
  }

  static bool get isDark => _isDark;

  static Color get background =>
      _isDark ? const Color(0xFF0B1020) : const Color(0xFFF8FAFC);
  static Color get surface =>
      _isDark ? const Color(0xFF111827) : const Color(0xFFFFFFFF);
  static Color get surfaceElevated =>
      _isDark ? const Color(0xFF1A2235) : const Color(0xFFEFF6FF);
  static Color get accent =>
      _isDark ? const Color(0xFF4F46E5) : const Color(0xFF2563EB);
  static Color get accentSecondary =>
      _isDark ? const Color(0xFF06B6D4) : const Color(0xFF0891B2);
  static Color get accentGlow =>
      _isDark ? const Color(0x334F46E5) : const Color(0x332563EB);
  static Color get textPrimary =>
      _isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);
  static Color get textSecondary =>
      _isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  static Color get textMuted =>
      _isDark ? const Color(0xFF64748B) : const Color(0xFF64748B);
  static Color get onAccent =>
      _isDark ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  static Color get interactiveText =>
      _isDark ? const Color(0xFFF8FAFC) : const Color(0xFF1E3A8A);
  static Color get interactiveSurface =>
      _isDark ? const Color(0xFF1E293B) : const Color(0xFFE0F2FE);
  static Color get border =>
      _isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0);
  static Color get borderLight =>
      _isDark ? const Color(0xFF2D3748) : const Color(0xFFCBD5E1);
  static const Color white = Color(0xFFFFFFFF);

  static LinearGradient get heroGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: _isDark
        ? const [Color(0xFF0B1020), Color(0xFF0F172A), Color(0xFF0B1020)]
        : const [Color(0xFFFFFFFF), Color(0xFFEFF6FF), Color(0xFFF8FAFC)],
  );

  static LinearGradient get accentGradient =>
      LinearGradient(colors: [accent, accentSecondary]);

  static LinearGradient get toggleTrackGradient => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: _isDark
        ? const [Color(0xFF111827), Color(0xFF1E293B)]
        : const [Color(0xFFE0F2FE), Color(0xFFEEF2FF)],
  );

  static LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: _isDark
        ? const [Color(0xFF1A2235), Color(0xFF111827)]
        : const [Color(0xFFFFFFFF), Color(0xFFEFF6FF)],
  );
}
