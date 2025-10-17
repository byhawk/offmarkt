import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/api_constants.dart';

/// API servis sınıfı - Tüm HTTP isteklerini yönetir
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Request interceptor - Token ekleme
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Token süresi dolmuşsa yenile
          if (error.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              // İsteği tekrar dene
              final opts = error.requestOptions;
              final token = await _storage.read(key: 'access_token');
              opts.headers['Authorization'] = 'Bearer $token';

              try {
                final response = await _dio.fetch(opts);
                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  /// Token yenileme
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        await _storage.write(
          key: 'access_token',
          value: response.data['accessToken'],
        );
        await _storage.write(
          key: 'refresh_token',
          value: response.data['refreshToken'],
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// GET isteği
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// POST isteği
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT isteği
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE isteği
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Hata yönetimi
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Bağlantı zaman aşımına uğradı';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'];

        if (statusCode == 400) {
          return message ?? 'Geçersiz istek';
        } else if (statusCode == 401) {
          return 'Oturum süreniz doldu, lütfen tekrar giriş yapın';
        } else if (statusCode == 403) {
          return 'Bu işlem için yetkiniz yok';
        } else if (statusCode == 404) {
          return 'İstenen kaynak bulunamadı';
        } else if (statusCode == 500) {
          return 'Sunucu hatası oluştu';
        }
        return message ?? 'Bir hata oluştu';
      case DioExceptionType.cancel:
        return 'İstek iptal edildi';
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') ?? false) {
          return 'İnternet bağlantınızı kontrol edin';
        }
        return 'Beklenmeyen bir hata oluştu';
      default:
        return 'Bir hata oluştu';
    }
  }

  /// Token kaydet
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  /// Token'ları temizle
  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  /// Token var mı kontrol et
  Future<bool> hasToken() async {
    final token = await _storage.read(key: 'access_token');
    return token != null;
  }

  // ============ MARKET API ============

  /// Pazar ürünlerini getir
  Future<List<Map<String, dynamic>>> getMarketProducts() async {
    try {
      final response = await get('/market/products');
      if (response.data['success'] == true) {
        final products = response.data['data']['products'] as List;
        return products.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      print('Market products error: $e');
      return [];
    }
  }
}
