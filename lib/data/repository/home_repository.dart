import '../model/course.dart';
import '../model/category.dart';
import '../model/banner.dart';
import '../model/teacher.dart';
import '../model/paged_list.dart';
import '../../network/api_service.dart';

/// 首页数据仓库：封装首页所有数据来源（对应 HomeRepository.kt）
class HomeRepository {
  // 注：文档示例为私有构造 HomeRepository._()，但 ViewModel 需要直接实例化，
  // 这里改为公开构造以便被 providers/home_view_model.dart 使用。
  HomeRepository();

  Future<PagedList<Course>> getFeaturedCourses(int pageSize) =>
      ApiService.getCourses(isFeatured: true, pageSize: pageSize);

  Future<List<Category>> getCategories() => ApiService.getCategories();

  Future<List<Banner>> getBanners() => ApiService.getBanners('home');

  Future<List<Teacher>> getTeachers() => ApiService.getTeachers();

  Future<PagedList<Course>> getCategoryCourses(
          String categoryIds, int pageSize) =>
      ApiService.getCourses(
          categoryIds: categoryIds, sortBy: 'latest', pageSize: pageSize);

  /// 课程列表（筛选 + 排序 + 分页）
  Future<PagedList<Course>> getCourses({
    String? categoryIds,
    String? sortBy,
    int? pageSize,
  }) =>
      ApiService.getCourses(
          categoryIds: categoryIds, sortBy: sortBy, pageSize: pageSize);

  /// 课程详情
  Future<Course> getCourseDetail(int courseId) =>
      ApiService.getCourseDetail(courseId);

  /// 课程搜索
  Future<PagedList<Course>> searchCourses(String keyword) =>
      ApiService.searchCourses(keyword);
}
