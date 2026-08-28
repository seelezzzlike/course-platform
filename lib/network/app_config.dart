/// 后端配置（对应 AppConfig.kt）
class AppConfig {
  AppConfig._();

  /// 接口根地址
  static const String apiBase = 'http://127.0.0.1:8000/api/v1';

  /// 静态资源根地址
  static const String apiHost = 'http://127.0.0.1:8000';

  /// 请求超时（秒）
  static const int connectTimeout = 15;
  static const int receiveTimeout = 15;

  /// 把相对路径图片拼成完整 URL（如 /static/xxx.png → http://host/static/xxx.png）
  static String resolveAssetUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    return apiHost + url;
  }
}
