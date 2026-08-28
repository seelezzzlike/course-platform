// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCourse _$MyCourseFromJson(Map<String, dynamic> json) => MyCourse(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  cover: json['cover'] as String?,
  teacher: json['teacher'] == null
      ? null
      : TeacherRef.fromJson(json['teacher'] as Map<String, dynamic>),
  courseType: json['courseType'] as String?,
  price: (json['price'] as num?)?.toDouble() ?? 0,
  totalChapters: (json['totalChapters'] as num?)?.toInt() ?? 0,
  learnedChapters: (json['learnedChapters'] as num?)?.toInt() ?? 0,
  lastLearnedAt: json['lastLearnedAt'] as String?,
);

Map<String, dynamic> _$MyCourseToJson(MyCourse instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'cover': instance.cover,
  'teacher': instance.teacher,
  'courseType': instance.courseType,
  'price': instance.price,
  'totalChapters': instance.totalChapters,
  'learnedChapters': instance.learnedChapters,
  'lastLearnedAt': instance.lastLearnedAt,
};
