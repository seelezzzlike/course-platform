import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

/// 首页横幅
@JsonSerializable()
class Banner {
  final int id;
  final String title;
  final String? imageUrl;
  final String? linkUrl;
  final String? position;

  const Banner({
    required this.id,
    this.title = '',
    this.imageUrl,
    this.linkUrl,
    this.position,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
