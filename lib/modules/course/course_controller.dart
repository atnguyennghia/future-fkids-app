import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/course_model.dart';
import 'package:futurekids/data/models/lesson_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/lesson/lesson_controller.dart';
import 'package:futurekids/modules/unit/unit_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final course = Get.arguments["course"] as CourseModel;
  final lesson = Get.arguments["lesson"] as LessonModel;
  final unitController = Get.find<UnitController>();
  final lessonController = Get.find<LessonController>();

  final selectedCategory = 0.obs;
  final listCategory = <CategoryModel>[].obs;

  void fetchCategory() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider.getListCategory(courseId: course.courseId).catchError((err) {
      Notify.error(err);
    });

    if (result != null) {
      listCategory.value = result;
    }
  }

  @override
  void onInit() {
    fetchCategory();
    // TODO: implement onInit
    super.onInit();
  }
}
