import '../base/base_view_model.dart';
import '../data/model/course.dart';
import '../data/model/my_course.dart';
import '../data/repository/my_course_repository.dart';

/// 我的课程 ViewModel（对应 MyCourseViewModel.kt）
class MyCourseViewModel extends BaseViewModel {
  // 接入后端后使用；当前 mock 阶段暂时未引用
  // ignore: unused_field
  final MyCourseRepository _repository = MyCourseRepository();

  List<MyCourse> _courses = [];
  List<MyCourse> get courses => _courses;

  /// 在学（未学完）课程数
  int get learningCount => _courses.where((c) => !c.isCompleted).length;

  /// 已学完课程数
  int get completedCount => _courses.where((c) => c.isCompleted).length;

  /// 平均学习进度（0.0 ~ 1.0）
  double get averageProgress {
    if (_courses.isEmpty) return 0;
    final total = _courses.fold<double>(0, (sum, c) => sum + c.progress);
    return total / _courses.length;
  }

  /// 平均进度百分比文案
  String get averageProgressText => '${(averageProgress * 100).round()}%';

  /// 加载我的课程
  Future<void> loadMyCourses() async {
    // 当前用 mock 数据演示；接入后端后改为：
    // await runApi(() async { _courses = await _repository.getMyCourses(); });
    await Future<void>.delayed(const Duration(milliseconds: 600));
    _courses = _mockCourses();
    notifyListeners();
  }

  // ---- 静态占位数据（演示用） ----
  List<MyCourse> _mockCourses() => const [
        MyCourse(
          id: 1,
          title: 'Flutter 移动开发实战',
          cover: '/static/course_flutter.png',
          teacher: TeacherRef(id: 1, name: '辛老师'),
          courseType: '系统录播',
          price: 0,
          totalChapters: 16,
          learnedChapters: 16,
          lastLearnedAt: '2026-08-26T10:00:00',
        ),
        MyCourse(
          id: 2,
          title: 'Android Jetpack 架构指南',
          cover: '/static/course_jetpack.png',
          teacher: TeacherRef(id: 2, name: '王老师'),
          courseType: '系统录播',
          price: 199,
          totalChapters: 24,
          learnedChapters: 12,
          lastLearnedAt: '2026-08-27T20:30:00',
        ),
        MyCourse(
          id: 3,
          title: 'Kotlin 协程与 Flow 精讲',
          cover: '/static/course_kotlin.png',
          teacher: TeacherRef(id: 3, name: '李老师'),
          courseType: '直播回放',
          price: 129,
          totalChapters: 20,
          learnedChapters: 5,
          lastLearnedAt: '2026-08-25T15:20:00',
        ),
        MyCourse(
          id: 4,
          title: 'Compose 声明式 UI 入门',
          cover: '/static/course_compose.png',
          teacher: TeacherRef(id: 4, name: '赵老师'),
          courseType: '系统录播',
          price: 0,
          totalChapters: 10,
          learnedChapters: 3,
          lastLearnedAt: '2026-08-24T09:00:00',
        ),
      ];
}
