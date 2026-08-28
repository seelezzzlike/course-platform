import 'package:json_annotation/json_annotation.dart';
import 'course.dart';

part 'my_course.g.dart';

/// 已购课程（对应后端 MyCourseVO：课程 + 学习进度）
@JsonSerializable()
class MyCourse {
  final int id;
  final String title;
  final String? cover;
  final TeacherRef? teacher;
  final String? courseType;
  final double price;
  final int totalChapters;
  final int learnedChapters;

  /// 最近学习时间（ISO 字符串，如 2026-08-28T10:00:00）
  final String? lastLearnedAt;

  const MyCourse({
    required this.id,
    this.title = '',
    this.cover,
    this.teacher,
    this.courseType,
    this.price = 0,
    this.totalChapters = 0,
    this.learnedChapters = 0,
    this.lastLearnedAt,
  });

  /// 讲师姓名快捷方式
  String get teacherName => teacher?.name ?? '';

  /// 学习进度（0.0 ~ 1.0）
  double get progress =>
      totalChapters <= 0 ? 0 : (learnedChapters / totalChapters).clamp(0.0, 1.0);

  /// 进度百分比文案（如 60%）
  String get progressText => '${(progress * 100).round()}%';

  /// 是否已学完
  bool get isCompleted => totalChapters > 0 && learnedChapters >= totalChapters;

  /// 是否免费（价格 <= 0 视为免费）
  bool get isFree => price <= 0;

  /// 价格文案
  String get priceText => isFree ? '免费' : '¥${price.toStringAsFixed(2)}';

  factory MyCourse.fromJson(Map<String, dynamic> json) => _$MyCourseFromJson(json);
  Map<String, dynamic> toJson() => _$MyCourseToJson(this);
}
