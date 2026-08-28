import 'http_client.dart';
import '../data/model/course.dart';
import '../data/model/category.dart';
import '../data/model/banner.dart';
import '../data/model/teacher.dart';
import '../data/model/paged_list.dart';

/// 后端 API 接口定义（对应 ApiService.kt）
class ApiService {
  ApiService._();

  /// 课程分类
  static Future<List<Category>> getCategories() =>
      HttpClient.get('courses/categories', parser: _parseListOfCategory);

  /// 课程列表（is_featured / category_ids / sort_by / page_size）
  static Future<PagedList<Course>> getCourses({
    bool? isFeatured,
    String? categoryIds,
    String? sortBy,
    int? pageSize,
  }) =>
      HttpClient.get(
        'courses',
        query: {
          'is_featured': isFeatured,
          'category_ids': categoryIds,
          'sort_by': sortBy,
          'page_size': pageSize,
        }..removeWhere((_, v) => v == null),
        parser: (data) =>
            PagedList<Course>.fromJson(data, (e) => Course.fromJson(e)),
      );

  /// 讲师列表
  static Future<List<Teacher>> getTeachers() =>
      HttpClient.get('courses/teachers', parser: _parseListOfTeacher);

  /// 首页横幅
  static Future<List<Banner>> getBanners(String position) =>
      HttpClient.get('content/banners', query: {'position': position}, parser: _parseListOfBanner);

  /// 课程详情
  static Future<Course> getCourseDetail(int courseId) =>
      HttpClient.get('courses/$courseId', parser: (d) => Course.fromJson(d));

  /// 课程搜索
  static Future<PagedList<Course>> searchCourses(String keyword, {int page = 1}) =>
      HttpClient.get(
        'courses/search',
        query: {'keyword': keyword, 'page': page},
        parser: (data) => PagedList<Course>.fromJson(data, (e) => Course.fromJson(e)),
      );

  // ---- 内部解析工具 ----
  static List<T> _parseList<T>(dynamic data, T Function(Map<String, dynamic>) parser) =>
      (data as List).map((e) => parser(e as Map<String, dynamic>)).toList();
  static List<Category> _parseListOfCategory(dynamic d) => _parseList(d, Category.fromJson);
  static List<Teacher> _parseListOfTeacher(dynamic d) => _parseList(d, Teacher.fromJson);
  static List<Banner> _parseListOfBanner(dynamic d) => _parseList(d, Banner.fromJson);
}
