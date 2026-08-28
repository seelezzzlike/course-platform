import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/colors.dart';
import '../../../config/dimens.dart';
import '../../../network/app_config.dart';
import '../../../data/model/course.dart';

/// 课程卡片（对应 item_course_card.xml）
class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseCard({super.key, required this.course, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面 + 徽章
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: AppConfig.resolveAssetUrl(course.cover),
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(color: AppColors.bgInput),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.brandPrimary.withValues(alpha: 0.2),
                      child: const Icon(Icons.image, color: AppColors.textMuted),
                    ),
                  ),
                ),
                // 课程类型徽章
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                    ),
                    child: Text(
                      course.courseType ?? '录播',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题（最多 2 行省略）
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: AppDimens.textSm,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 讲师
                  Text(
                    course.teacherName.isNotEmpty
                        ? '${course.teacherName} · ${course.categoryName ?? ''}'
                        : (course.categoryName ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimens.textXs,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // 底部行：学习人数 + 价格
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${course.studentCount}人学习',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: AppDimens.textXs,
                        ),
                      ),
                      Text(
                        course.priceText,
                        style: TextStyle(
                          color: course.isFree
                              ? AppColors.success
                              : AppColors.brandPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
