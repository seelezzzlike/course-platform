import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

/// 讲师
@JsonSerializable()
class Teacher {
  final int id;
  final String name;
  final String? title;
  final String? avatar;
  final String? intro;

  const Teacher({
    required this.id,
    this.name = '',
    this.title,
    this.avatar,
    this.intro,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
