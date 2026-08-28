import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../providers/my_course_view_model.dart';
import 'my_course_page.dart';

/// 我的课程状态容器：处理 loading / error / data 三态
class MyCourseStateContainer extends StatelessWidget {
  const MyCourseStateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyCourseViewModel>();
    return Stack(
      children: [
        const MyCoursePage(),
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
    );
  }
}
