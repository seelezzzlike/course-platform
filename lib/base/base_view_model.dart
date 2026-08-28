import 'package:flutter/foundation.dart';

/// 所有 ViewModel 的基类（对应 BaseViewModel.kt）
abstract class BaseViewModel extends ChangeNotifier {
  bool _loading = false;
  String? _error;

  /// 是否加载中
  bool get loading => _loading;

  /// 错误信息（null 表示无错误）
  String? get error => _error;

  /// 统一执行网络请求：
  /// 1. 置 loading=true 并通知 UI
  /// 2. 执行 action（真实的网络请求）
  /// 3. 捕获异常写入 error
  /// 4. 最终置 loading=false 并通知 UI
  Future<void> runApi(Future<void> Function() action) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
