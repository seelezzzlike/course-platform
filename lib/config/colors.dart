import 'package:flutter/material.dart';

/// 全局颜色定义（对应 colors.xml + Design Tokens）
class AppColors {
  AppColors._();

  // 品牌色
  static const Color brandPrimary = Color(0xFF00C4D4); // 主青绿
  static const Color brandDark = Color(0xFF00A8B8);    // 暗青绿
  static const Color brandPurple = Color(0xFF6D28D9);  // 次紫

  // 背景
  static const Color bgLight = Color(0xFFF5F5F7);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgInput = Color(0xFFF2F3F7);

  // 文字
  static const Color textMain = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFFFFFFFF);

  // 分割线
  static const Color divider = Color(0xFFE5E7EB);

  // 状态色
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
