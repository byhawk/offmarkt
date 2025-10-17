/// API sabitleri
class ApiConstants {
  // Base URL - Production server
  static const String baseUrl = 'http://213.142.159.245:3000/api';

  // WebSocket URL
  static const String wsUrl = 'http://213.142.159.245:3000';

  // Endpoints
  static const String auth = '/auth';
  static const String player = '/player';
  static const String market = '/market';
  static const String shop = '/shop';
  static const String trade = '/trade';
  static const String event = '/event';
  static const String leaderboard = '/leaderboard';
  static const String admin = '/admin';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
}
