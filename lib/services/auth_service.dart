import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/api_constants.dart';

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthService({Dio? dio, FlutterSecureStorage? storage})
    : _dio = dio ?? Dio(),
      _storage = storage ?? const FlutterSecureStorage() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = ApiConstants.connectTimeout;
    _dio.options.receiveTimeout = ApiConstants.receiveTimeout;
  }

  // Register
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String username,
    required String name,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.auth}/register',
        data: {
          'email': email,
          'password': password,
          'username': username,
          'name': name,
        },
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        await _saveTokens(data['accessToken'], data['refreshToken']);
        await _saveUserData(data['player']);
        return data;
      }

      throw Exception(response.data['message'] ?? 'Registration failed');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Login
  Future<Map<String, dynamic>> login({
    String? email,
    String? username,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> loginData = {'password': password};

      // Email veya username ile login (ikisinden biri gerekli)
      if (email != null && email.isNotEmpty) {
        loginData['email'] = email;
      } else if (username != null && username.isNotEmpty) {
        loginData['username'] = username;
      } else {
        throw Exception('Email veya kullanıcı adı gerekli');
      }

      final response = await _dio.post(
        '${ApiConstants.auth}/login',
        data: loginData,
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        await _saveTokens(data['accessToken'], data['refreshToken']);
        await _saveUserData(data['player']);
        return data;
      }

      throw Exception(response.data['message'] ?? 'Login failed');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final token = await getAccessToken();
      if (token != null) {
        await _dio.post(
          '${ApiConstants.auth}/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
      }
    } catch (e) {
      // Ignore logout errors
    } finally {
      await _clearTokens();
    }
  }

  // Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final token = await getAccessToken();
      if (token == null) return null;

      final response = await _dio.get(
        '${ApiConstants.auth}/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.data['success'] == true) {
        final player = response.data['data'];
        await _saveUserData(player);
        return player;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Refresh token
  Future<String?> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) return null;

      final response = await _dio.post(
        '${ApiConstants.auth}/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.data['success'] == true) {
        final accessToken = response.data['data']['accessToken'];
        await _storage.write(
          key: ApiConstants.accessTokenKey,
          value: accessToken,
        );
        return accessToken;
      }

      return null;
    } catch (e) {
      await _clearTokens();
      return null;
    }
  }

  // Token management
  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: ApiConstants.accessTokenKey, value: accessToken);
    await _storage.write(
      key: ApiConstants.refreshTokenKey,
      value: refreshToken,
    );
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    await _storage.write(
      key: ApiConstants.userDataKey,
      value: userData.toString(),
    );
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: ApiConstants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: ApiConstants.refreshTokenKey);
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: ApiConstants.accessTokenKey);
    await _storage.delete(key: ApiConstants.refreshTokenKey);
    await _storage.delete(key: ApiConstants.userDataKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  // Error handling
  String _handleError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map && data['message'] != null) {
        return data['message'];
      }
      return 'Server error: ${e.response!.statusCode}';
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'Cannot connect to server. Please check your internet connection.';
    }

    return 'An unexpected error occurred';
  }
}
