import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/dimens.dart';
import '../../network/app_config.dart';
import '../../providers/my_course_view_model.dart';
import '../../data/model/my_course.dart';

/// 我的课程页面（对应 MyCourseFragment）
class MyCoursePage extends StatelessWidget {
  const MyCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyCourseViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '我的课程',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => vm.loadMyCourses(),
        child: vm.courses.isEmpty
            ? const _EmptyView()
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppDimens.space12),
                children: [
                  _StatsCard(vm: vm),
                  const SizedBox(height: AppDimens.space12),
                  ...vm.courses.map((c) => _CourseProgressTile(course: c)),
                ],
              ),
      ),
    );
  }
}

/// 顶部统计卡片：在学 / 已学完 / 平均进度
class _StatsCard extends StatelessWidget {
  final MyCourseViewModel vm;
  const _StatsCard({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space16,
        vertical: AppDimens.space16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brandPrimary, AppColors.brandPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(label: '在学', value: '${vm.learningCount}'),
          _StatItem(label: '已学完', value: '${vm.completedCount}'),
          _StatItem(label: '平均进度', value: vm.averageProgressText),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: AppDimens.textXl,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.space4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: AppDimens.textXs,
          ),
        ),
      ],
    );
  }
}

/// 单个已购课程：封面 + 标题 + 学习进度条
class _CourseProgressTile extends StatelessWidget {
  final MyCourse course;
  const _CourseProgressTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.space12),
      padding: const EdgeInsets.all(AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 封面
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            child: SizedBox(
              width: 96,
              height: 60,
              child: CachedNetworkImage(
                imageUrl: AppConfig.resolveAssetUrl(course.cover),
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.bgInput),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.brandPrimary.withValues(alpha: 0.2),
                  child: const Icon(Icons.play_circle,
                      color: AppColors.textMuted),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimens.space12),
          // 信息 + 进度
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: AppDimens.textMd,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppDimens.space4),
                Text(
                  '${course.teacherName} · ${course.courseType ?? '录播'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimens.textXs,
                  ),
                ),
                const SizedBox(height: AppDimens.space8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusPill),
                        child: LinearProgressIndicator(
                          value: course.progress,
                          minHeight: 6,
                          backgroundColor: AppColors.bgInput,
                          valueColor: AlwaysStoppedAnimation(
                            course.isCompleted
                                ? AppColors.success
                                : AppColors.brandPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.space8),
                    Text(
                      course.isCompleted ? '已完成' : course.progressText,
                      style: TextStyle(
                        fontSize: AppDimens.textXs,
                        fontWeight: FontWeight.w600,
                        color: course.isCompleted
                            ? AppColors.success
                            : AppColors.brandPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 空状态：暂无已购课程
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: constraints.maxHeight,
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school_outlined,
                    size: 64, color: AppColors.textMuted),
                SizedBox(height: AppDimens.space12),
                Text(
                  '暂无已购课程',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
