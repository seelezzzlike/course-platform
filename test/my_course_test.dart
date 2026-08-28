import 'package:flutter_test/flutter_test.dart';
import 'package:taoyue_edu_app/data/model/course.dart';
import 'package:taoyue_edu_app/data/model/my_course.dart';
import 'package:taoyue_edu_app/providers/my_course_view_model.dart';

void main() {
  group('MyCourse 模型', () {
    test('进度计算：learned/total 四舍五入为百分比', () {
      const course = MyCourse(
        id: 1,
        title: '测试课程',
        totalChapters: 10,
        learnedChapters: 3,
      );
      expect(course.progress, closeTo(0.3, 0.001));
      expect(course.progressText, '30%');
      expect(course.isCompleted, isFalse);
    });

    test('学完状态：learned >= total 视为已完成', () {
      const course = MyCourse(
        id: 2,
        title: '已完成课程',
        totalChapters: 10,
        learnedChapters: 10,
      );
      expect(course.isCompleted, isTrue);
      expect(course.progressText, '100%');
    });

    test('totalChapters 为 0 时进度为 0 不崩溃', () {
      const course = MyCourse(id: 3, title: '空课程');
      expect(course.progress, 0);
      expect(course.progressText, '0%');
      expect(course.isCompleted, isFalse);
    });

    test('价格文案：免费与付费', () {
      const free = MyCourse(id: 4, title: '免费课', price: 0);
      const paid = MyCourse(id: 5, title: '付费课', price: 199);
      expect(free.priceText, '免费');
      expect(paid.priceText, '¥199.00');
    });

    test('讲师姓名快捷方式', () {
      const course = MyCourse(
        id: 6,
        title: '有讲师课程',
        teacher: TeacherRef(id: 1, name: '辛老师'),
      );
      expect(course.teacherName, '辛老师');
    });

    test('JSON 序列化往返一致', () {
      const course = MyCourse(
        id: 7,
        title: '序列化课程',
        cover: '/static/a.png',
        totalChapters: 8,
        learnedChapters: 2,
      );
      final restored = MyCourse.fromJson(course.toJson());
      expect(restored.id, course.id);
      expect(restored.title, course.title);
      expect(restored.totalChapters, 8);
      expect(restored.progressText, '25%');
    });
  });

  group('MyCourseViewModel', () {
    test('加载后提供已购课程与统计', () async {
      final vm = MyCourseViewModel();
      await vm.loadMyCourses();

      expect(vm.courses, isNotEmpty);
      expect(vm.courses.length, 4);
      // 4 门中 1 门已学完
      expect(vm.learningCount, 3);
      expect(vm.completedCount, 1);
      // 平均进度 = (1 + 0.5 + 0.25 + 0.3) / 4 = 0.5125 -> 51%
      expect(vm.averageProgressText, '51%');
    });
  });
}
