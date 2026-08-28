/// 业务异常（对应 ApiException.kt）
class ApiException implements Exception {
  final int code;
  final String message;

  const ApiException(this.code, this.message);

  @override
  String toString() => 'ApiException(code=$code, message=$message)';
}
