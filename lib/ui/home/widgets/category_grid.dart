import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/colors.dart';
import '../../../config/dimens.dart';
import '../../../providers/home_view_model.dart';
import '../../../data/model/category.dart';

/// 首页分类宫格（对应 category_grid，4 列）
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<HomeViewModel>().categories;
    if (categories.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space12),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppDimens.space8,
        childAspectRatio: 0.9,
        children: categories.map((c) => _CategoryItem(category: c)).toList(),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 图标圆底
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.bgInput,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          child: const Icon(
            Icons.category_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          category.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: AppDimens.textXs),
        ),
      ],
    );
  }
}
