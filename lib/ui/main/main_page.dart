import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../config/app_config.dart';
import '../home/home_state_container.dart';
import '../common/placeholder_page.dart';

/// 主界面：底部导航 + 页面容器（对应 MainActivity.kt）
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  /// IndexedStack 保证切换 Tab 时页面状态不丢失
  final List<Widget> _pages = const [
    HomeStateContainer(),
    PlaceholderPage(title: AppStrings.category),
    PlaceholderPage(title: AppStrings.course),
    PlaceholderPage(title: AppStrings.mine),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.brandPrimary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: AppStrings.category,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            activeIcon: Icon(Icons.play_circle),
            label: AppStrings.course,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppStrings.mine,
          ),
        ],
      ),
    );
  }
}
