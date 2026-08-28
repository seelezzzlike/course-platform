import '../base/base_view_model.dart';
import '../data/model/course.dart';
import '../data/model/category.dart';
import '../data/model/banner.dart';
import '../data/model/teacher.dart';
import '../data/repository/home_repository.dart';

/// 首页 ViewModel（对应 HomeViewModel.kt）
///
/// 暴露多个状态字段（对应多个 StateFlow）：
/// - banners / categories / featuredCourses / categoryCourses / teachers
/// - loading / error
class HomeViewModel extends BaseViewModel {
  // 接入后端后使用；当前 mock 阶段暂时未引用
  // ignore: unused_field
  final HomeRepository _repository = HomeRepository();

  List<Banner> _banners = [];
  List<Category> _categories = [];
  List<Course> _featuredCourses = [];
  Map<int, List<Course>> _categoryCourses = {};
  List<Teacher> _teachers = [];

  List<Banner> get banners => _banners;
  List<Category> get categories => _categories;
  List<Course> get featuredCourses => _featuredCourses;
  Map<int, List<Course>> get categoryCourses => _categoryCourses;
  List<Teacher> get teachers => _teachers;

  /// 加载首页全部数据
  Future<void> loadHome() async {
    // 当前用 mock 数据演示；接入后端后改为：
    // _banners = await _repository.getBanners();
    // _categories = await _repository.getCategories();
    // _featuredCourses = (await _repository.getFeaturedCourses(6)).safeItems;
    // _teachers = await _repository.getTeachers();
    _loadMock();
    notifyListeners();
  }

  // ---- 静态占位数据（演示用） ----
  void _loadMock() {
    _banners = mockBanners();
    _categories = mockCategories();
    _featuredCourses = mockFeaturedCourses();
    _categoryCourses = mockCategoryCourses();
    _teachers = mockTeachers();
  }

  List<Banner> mockBanners() => const [
        Banner(id: 1, title: '限时特惠', imageUrl: '/static/banner1.png'),
        Banner(id: 2, title: '新课上线', imageUrl: '/static/banner2.png'),
        Banner(id: 3, title: '名师直播', imageUrl: '/static/banner3.png'),
      ];

  List<Category> mockCategories() => List.generate(
        8,
        (i) => Category(id: i + 1, name: '分类${i + 1}'),
      );

  List<Course> mockFeaturedCourses() => List.generate(
        8,
        (i) => Course(
          id: i + 1,
          title: '精选课程 ${i + 1}',
          price: i == 0 ? 0 : (99 + i * 100).toDouble(),
          studentCount: 1000 + i * 100,
          teacher: const TeacherRef(id: 1, name: '辛老师'),
          categoryName: '分类${(i % 8) + 1}',
          courseType: '系统录播',
        ),
      );

  Map<int, List<Course>> mockCategoryCourses() =>
      {for (final c in mockCategories()) c.id: mockFeaturedCourses()};

  List<Teacher> mockTeachers() => List.generate(
        4,
        (i) => Teacher(id: i + 1, name: '辛老师${i + 1}', title: '金牌讲师'),
      );
}
