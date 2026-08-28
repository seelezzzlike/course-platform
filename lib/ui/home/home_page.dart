import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/dimens.dart';
import '../../config/app_config.dart';
import '../../providers/home_view_model.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/category_grid.dart';
import 'widgets/course_card.dart';

/// 首页
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 品牌 + 搜索区
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              AppStrings.appName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: AppDimens.space12),
            Expanded(
              child: _buildSearchBar(),
            ),
          ],
        ),
      ),
      body: const _HomeBody(),
    );
  }

  // 搜索框
  Widget _buildSearchBar() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.bgInput,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      child: const Row(
        children: [
          SizedBox(width: 8),
          Icon(Icons.search, color: AppColors.textMuted, size: 20),
          SizedBox(width: 4),
          Text(
            AppStrings.searchHint,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: AppDimens.textSm,
            ),
          ),
        ],
      ),
    );
  }
}

/// 首页可滚动主体
class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        const SliverToBoxAdapter(child: BannerCarousel()),
        const SliverToBoxAdapter(child: CategoryGrid()),
        const SliverToBoxAdapter(child: _FeaturedTitle()),
        // 精选课程双列网格
        Consumer<HomeViewModel>(
          builder: (context, vm, _) {
            final courses = vm.featuredCourses;
            if (courses.isEmpty) {
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            }
            return SliverPadding(
              padding: const EdgeInsets.all(AppDimens.space12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => CourseCard(course: courses[index]),
                  childCount: courses.length,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const SizedBox(height: AppDimens.space8);
  }
}

/// 精选好课标题行
class _FeaturedTitle extends StatelessWidget {
  const _FeaturedTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space8,
      ),
      child: Row(
        children: [
          // 渐变竖条
          Container(
            width: 4,
            height: 18,
            decoration: const BoxDecoration(
              color: AppColors.brandPrimary,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '精选好课',
            style: TextStyle(
              fontSize: AppDimens.textLg,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
