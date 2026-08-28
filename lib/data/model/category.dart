import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// 课程分类
@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String slug;
  final String? icon;
  final String? description;
  final int courseCount;
  final int? parentId;

  /// 子分类（递归）
  final List<Category>? children;

  const Category({
    required this.id,
    this.name = '',
    this.slug = '',
    this.icon,
    this.description,
    this.courseCount = 0,
    this.parentId,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
