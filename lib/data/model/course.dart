import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

/// 课程实体（对应后端真实字段）
@JsonSerializable()
class Course {
  final int id;
  final String slug;
  final String title;
  final String? subtitle;
  final String? cover;
  final double price;
  final double originalPrice;
  final int? categoryId;
  final String? categoryName;
  final TeacherRef? teacher;
  final String? courseType;
  final int studentCount;
  final double rating;
  final int reviewCount;
  final double durationHours;
  final String? status;

  const Course({
    required this.id,
    this.slug = '',
    this.title = '',
    this.subtitle,
    this.cover,
    this.price = 0,
    this.originalPrice = 0,
    this.categoryId,
    this.categoryName,
    this.teacher,
    this.courseType,
    this.studentCount = 0,
    this.rating = 0,
    this.reviewCount = 0,
    this.durationHours = 0,
    this.status,
  });

  /// 讲师姓名快捷方式
  String get teacherName => teacher?.name ?? '';

  /// 是否免费（价格 <= 0 视为免费）
  bool get isFree => price <= 0;

  /// 价格文案
  String get priceText => isFree ? '免费' : '¥${price.toStringAsFixed(2)}';

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

/// 讲师引用（嵌套于课程中的讲师信息）
@JsonSerializable()
class TeacherRef {
  final int id;
  final String name;
  final String? avatar;
  final String? title;

  const TeacherRef({
    required this.id,
    this.name = '',
    this.avatar,
    this.title,
  });

  factory TeacherRef.fromJson(Map<String, dynamic> json) =>
      _$TeacherRefFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherRefToJson(this);
}
