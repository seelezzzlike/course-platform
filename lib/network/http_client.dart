import 'package:dio/dio.dart';
import 'app_config.dart';
import 'api_response.dart';
import 'api_exception.dart';
import 'token_interceptor.dart';

/// 网络层统一入口（对应 RetrofitClient.kt）
class HttpClient {
  HttpClient._();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBase,
      connectTimeout: const Duration(seconds: AppConfig.connectTimeout),
      receiveTimeout: const Duration(seconds: AppConfig.receiveTimeout),
      responseType: ResponseType.json,
    ),
  )..interceptors.addAll([
      // 日志拦截器（调试用，发布前建议移除）
      LogInterceptor(responseBody: true),
      // Token 拦截器
      TokenInterceptor(),
    ]);

  /// 获取 dio 实例
  static Dio get instance => _dio;

  /// 统一 GET 请求，自动解析 ApiResponse 并做业务校验
  static Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: query,
      );
      final json = resp.data;
      if (json == null) throw const ApiException(-1, '响应为空');
      final apiResp = ApiResponse<T>.fromJson(json, parser);
      if (!apiResp.isSuccess) {
        throw ApiException(apiResp.code, apiResp.message ?? '请求失败');
      }
      if (apiResp.data == null) throw const ApiException(-1, '数据为空');
      return apiResp.data!;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.statusCode ?? -1,
        e.message ?? '网络异常，请稍后重试',
      );
    }
  }

  /// 统一 POST 请求（登录等场景），自动解析 ApiResponse 并做业务校验
  static Future<T> post<T>(
    String path, {
    Map<String, dynamic>? data,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final resp = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
      );
      final json = resp.data;
      if (json == null) throw const ApiException(-1, '响应为空');
      final apiResp = ApiResponse<T>.fromJson(json, parser);
      if (!apiResp.isSuccess) {
        throw ApiException(apiResp.code, apiResp.message ?? '请求失败');
      }
      if (apiResp.data == null) throw const ApiException(-1, '数据为空');
      return apiResp.data!;
    } on DioException catch (e) {
      throw ApiException(
        e.response?.statusCode ?? -1,
        e.message ?? '网络异常，请稍后重试',
      );
    }
  }
}
