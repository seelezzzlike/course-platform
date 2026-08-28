import '../model/my_course.dart';
import '../../network/api_service.dart';

/// 我的课程数据仓库：封装已购课程相关数据来源（对应 MyCourseRepository.kt）
class MyCourseRepository {
  MyCourseRepository();

  /// 获取当前用户的已购课程列表
  Future<List<MyCourse>> getMyCourses() => ApiService.getMyCourses();
}
