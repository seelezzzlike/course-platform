import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../providers/home_view_model.dart';
import 'home_page.dart';

/// 首页状态容器：处理 loading / error / data 三态
class HomeStateContainer extends StatelessWidget {
  const HomeStateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          const HomePage(),
          // 加载遮罩
          if (vm.loading) const Center(child: CircularProgressIndicator()),
          // 错误提示
          if (vm.error != null)
            Center(
              child: Text(
                vm.error!,
                style: const TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
    );
  }
}

/// 首页下拉刷新（在 CustomScrollView 外套 RefreshIndicator）
class HomeRefresh extends StatelessWidget {
  const HomeRefresh({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewModel>();
    return RefreshIndicator(
      onRefresh: () => vm.loadHome(),
      child: const HomePage(),
    );
  }
}
