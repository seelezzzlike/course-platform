import 'dart:async';
import 'package:flutter/material.dart' hide Banner;
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/colors.dart';
import '../../../config/dimens.dart';
import '../../../network/app_config.dart';
import '../../../providers/home_view_model.dart';
import '../../../data/model/banner.dart';

/// Banner 轮播组件（对应 ViewPager2 + 指示点）
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _controller = PageController();
  Timer? _timer;
  int _current = 0;
  List<Banner> _banners = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 从 HomeViewModel 读取数据（真实项目用 Consumer 监听）
    final vm = context.read<HomeViewModel>();
    _banners = vm.banners;
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    if (_banners.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;
      final next = (_current + 1) % _banners.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_banners.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(AppDimens.space12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            child: SizedBox(
              height: 150,
              child: PageView.builder(
                controller: _controller,
                itemCount: _banners.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (context, index) {
                  final b = _banners[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: AppConfig.resolveAssetUrl(b.imageUrl),
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.bgInput),
                      ),
                      if (b.title.isNotEmpty)
                        Positioned(
                          left: 12,
                          bottom: 12,
                          child: Text(
                            b.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppDimens.textMd,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 指示点
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (i) {
              final active = i == _current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: active ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: active ? AppColors.brandPrimary : AppColors.textMuted,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
