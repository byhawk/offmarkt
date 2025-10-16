import 'package:intl/intl.dart';

/// Utility fonksiyonları - formatlama
class Formatters {
  Formatters._();

  /// Para formatı: 1234.56 -> "1.234,56 ₺"
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0.00', 'tr_TR');
    return '${formatter.format(amount)} ₺';
  }

  /// Kısa para formatı: 1234567 -> "1,23M ₺"
  static String formatCurrencyShort(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(2)}M ₺';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K ₺';
    }
    return formatCurrency(amount);
  }

  /// Sayı formatı: 1234 -> "1.234"
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,##0', 'tr_TR');
    return formatter.format(number);
  }

  /// Yüzde formatı: 0.1234 -> "%12,34"
  static String formatPercentage(double value) {
    return '%${(value * 100).toStringAsFixed(2)}';
  }

  /// Gün formatı: 15 -> "Gün 15"
  static String formatDay(int day) {
    return 'Gün $day';
  }
}
