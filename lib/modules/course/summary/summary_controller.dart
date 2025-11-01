import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class SummaryController extends GetxController {
  final courseController = Get.find<CourseController>();
  final selectedIndex = 0.obs;
  final listCategory = <CategoryModel>[].obs;
  double totalScore = 0.0;
  int averagePercent = 0;

  void fetchCategory() async {
    final provider = CourseProvider();
    final result = await provider
        .getListCategory(courseId: courseController.course.courseId)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      listCategory.value = result;

      double sumPercent = 0;
      for (var item in result) {
        totalScore += item.point;
        sumPercent += item.percentComplete;
      }

      averagePercent = (sumPercent / result.length).round();
    }
  }

  void changeView() async {
    await Future.delayed(const Duration(seconds: 5));
    selectedIndex.value = 1;
  }

  @override
  void onInit() {
    changeView();
    fetchCategory();
    super.onInit();
  }
}
