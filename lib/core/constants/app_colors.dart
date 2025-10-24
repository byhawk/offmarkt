import 'package:flutter/material.dart';

/// Uygulama renk paleti
class AppColors {
  AppColors._();

  // Primary Colors - Koyu Lacivertler
  static const Color primary = Color(0xFF1A237E); // Koyu Lacivert
  static const Color primaryDark = Color(0xFF101851);
  static const Color primaryLight = Color(0xFF2F3B9A);

  // Background Colors
  static const Color backgroundPrimary = Color(0xFF0A0E27);
  static const Color backgroundSecondary = Color(0xFF151B3D);
  static const Color backgroundCard = Color(0xFF1E2749);
  static const Color backgroundInput = Color(0xFF252E52);

  // Accent & Semantic Colors
  static const Color accentGold = Color(0xFFD4AF37); // Altın Sarısı Vurgu
  static const Color accentDarkOrange = Color(0xFFB87333); // Koyu Turuncu Vurgu

  static const Color success = Color(0xFF1B5E20); // Tok Yeşil (Finansal)
  static const Color successDark = Color(0xFF0C3B0E);
  static const Color danger = Color(0xFFB71C1C); // Tok Kırmızı (Finansal)
  static const Color dangerDark = Color(0xFF8A0F0F);
  static const Color warning = Color(0xFFE65100); // Koyu Turuncu
  static const Color warningDark = Color(0xFFBF360C);
  static const Color info = Color(0xFF0D47A1); // Koyu Mavi

  // Text & Neutral Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8C5D6);
  static const Color ashGrey = Color(0xFF6c757d); // Kül Grisi
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
    primaryLight,
    primary,
  ];

  static const List<Color> successGradient = [
    Color(0xFF2E7D32),
    success,
  ];

  static const List<Color> dangerGradient = [
    Color(0xFFD32F2F),
    danger,
  ];

  static const List<Color> warningGradient = [
    Color(0xFFF57C00),
    warning,
  ];

  static const List<Color> goldGradient = [
    Color(0xFFFBC02D),
    accentGold,
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
