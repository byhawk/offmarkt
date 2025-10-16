import 'package:flutter/material.dart';

/// Uygulama renk paleti
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF00D4FF);
  static const Color primaryDark = Color(0xFF00A8CC);
  static const Color primaryLight = Color(0xFF66E3FF);

  // Background Colors
  static const Color backgroundPrimary = Color(0xFF0A0E27);
  static const Color backgroundSecondary = Color(0xFF151B3D);
  static const Color backgroundCard = Color(0xFF1E2749);
  static const Color backgroundInput = Color(0xFF252E52);

  // Accent Colors
  static const Color success = Color(0xFF00FF87);
  static const Color successDark = Color(0xFF00D4AA);
  static const Color danger = Color(0xFFFF0844);
  static const Color dangerDark = Color(0xFFCC0036);
  static const Color warning = Color(0xFFFFAA00);
  static const Color warningDark = Color(0xFFCC8800);
  static const Color info = Color(0xFF0066FF);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8C5D6);
  static const Color textMuted = Color(0xFF6B7B94);
  static const Color textDisabled = Color(0xFF4A5568);

  // Border & Divider
  static const Color border = Color(0xFF2D3B56);
  static const Color divider = Color(0xFF1F2937);

  // Overlay
  static const Color overlay = Color(0x80000000);
  static const Color modalBackground = Color(0xE6000000);

  // Gradients
  static const List<Color> primaryGradient = [
    Color(0xFF00D4FF),
    Color(0xFF0066FF),
  ];

  static const List<Color> successGradient = [
    Color(0xFF00FF87),
    Color(0xFF00D4AA),
  ];

  static const List<Color> dangerGradient = [
    Color(0xFFFF0844),
    Color(0xFFFF6B9D),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFFFAA00),
    Color(0xFFFF6B00),
  ];

  static const List<Color> goldGradient = [
    Color(0xFFFFD700),
    Color(0xFFFFA500),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF1E2749),
    Color(0xFF0A0E27),
  ];

  static const List<Color> cardGradient = [
    Color(0xFF1E2749),
    Color(0xFF151B3D),
  ];
}
