import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';
import 'config/theme.dart';
import 'providers/home_view_model.dart';
import 'providers/my_course_view_model.dart';
import 'ui/main/main_page.dart';

/// 根组件（Provider + MaterialApp）
class TaoyueEduApp extends StatelessWidget {
  const TaoyueEduApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 首页 ViewModel：App 启动即加载首页数据
        ChangeNotifierProvider(create: (_) => HomeViewModel()..loadHome()),
        // 我的课程 ViewModel：懒加载（切换到「我的」Tab 时加载）
        ChangeNotifierProvider(create: (_) => MyCourseViewModel()..loadMyCourses()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: AppTheme.light(),
        home: const MainPage(),
      ),
    );
  }
}
