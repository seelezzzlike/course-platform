/// 统一响应包装（对应 ApiResponse.kt）
class ApiResponse<T> {
  final int code;
  final String? message;
  final T? data;

  const ApiResponse({required this.code, this.message, this.data});

  /// 是否成功（code == 0 视为成功）
  bool get isSuccess => code == 0;

  /// 从 JSON 构造（data 用 converter 手动解析）
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data)? dataParser,
  ) {
    final raw = json['data'];
    return ApiResponse(
      code: json['code'] as int? ?? -1,
      message: json['message'] as String?,
      data: raw == null ? null : dataParser?.call(raw),
    );
  }
}
