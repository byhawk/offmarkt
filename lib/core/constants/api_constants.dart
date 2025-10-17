/// API sabitleri
class ApiConstants {
  // Base URL - Production'da değiştirilecek
  static const String baseUrl = 'http://localhost:3000/api';

  // WebSocket URL
  static const String wsUrl = 'http://localhost:3001';

  // Endpoints
  static const String auth = '/auth';
  static const String player = '/player';
  static const String market = '/market';
  static const String shop = '/shop';
  static const String trade = '/trade';
  static const String event = '/event';
  static const String leaderboard = '/leaderboard';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
