import 'package:json_annotation/json_annotation.dart';

part 'paged_list.g.dart';

/// 分页数据包装（对应后端 {items: [...], total: N}）
@JsonSerializable(genericArgumentFactories: true)
class PagedList<T> {
  final List<T>? items;
  final int total;
  final int page;
  final int pageSize;

  const PagedList({
    this.items,
    this.total = 0,
    this.page = 0,
    this.pageSize = 0,
  });

  /// 安全获取列表，为空时返回空列表
  List<T> get safeItems => items ?? [];

  /// 总页数（用于分页判断是否还有更多）
  int get totalPages => pageSize <= 0 ? 0 : (total + pageSize - 1) ~/ pageSize;

  factory PagedList.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) =>
      _$PagedListFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(T) toJsonT) =>
      _$PagedListToJson(this, toJsonT);
}
