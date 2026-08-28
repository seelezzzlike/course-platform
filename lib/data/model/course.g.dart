// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      slug: json['slug'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
      cover: json['cover'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      originalPrice: (json['originalPrice'] as num?)?.toDouble() ?? 0,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      teacher: json['teacher'] == null
          ? null
          : TeacherRef.fromJson(json['teacher'] as Map<String, dynamic>),
      courseType: json['courseType'] as String?,
      studentCount: (json['studentCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      durationHours: (json['durationHours'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'cover': instance.cover,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'teacher': instance.teacher,
      'courseType': instance.courseType,
      'studentCount': instance.studentCount,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'durationHours': instance.durationHours,
      'status': instance.status,
    };

TeacherRef _$TeacherRefFromJson(Map<String, dynamic> json) => TeacherRef(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$TeacherRefToJson(TeacherRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'title': instance.title,
    };
