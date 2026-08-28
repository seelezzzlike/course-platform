/// 统一结果封装（对应 ApiResult.kt）
sealed class ApiResult<T> {}

/// 成功
class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  ApiSuccess(this.data);
}

/// 失败
class ApiFailure<T> extends ApiResult<T> {
  final String message;
  ApiFailure(this.message);
}
