import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/dimens.dart';

/// 占位页（对应待实现的模块）
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.construction, size: 64, color: AppColors.textMuted),
            const SizedBox(height: AppDimens.space12),
            Text(
              '「$title」模块开发中',
              style: const TextStyle(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
