// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedList<T> _$PagedListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PagedList<T>(
      items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList(),
      total: (json['total'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PagedListToJson<T>(
  PagedList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items?.map(toJsonT).toList(),
      'total': instance.total,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
