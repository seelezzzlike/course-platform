import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Token 拦截器（对应 TokenInterceptor.kt）
class TokenInterceptor extends Interceptor {
  /// 在请求前附加 Authorization 头
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    options.headers['Authorization'] = token;
    handler.next(options);
  }
}
