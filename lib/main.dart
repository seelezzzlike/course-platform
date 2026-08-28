import 'package:flutter/material.dart';
import 'app.dart';
import 'config/system_ui.dart';

/// 全局入口（对应 MainActivity.kt）
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupImmersive(); // 沉浸式状态栏
  runApp(const TaoyueEduApp());
}
