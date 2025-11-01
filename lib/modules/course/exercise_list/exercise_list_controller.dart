import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/exercise_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class ExerciseListController extends GetxController {
  CategoryModel category;
  int selectedIndex = 0;

  ExerciseListController({required this.category});

  final courseController = Get.find<CourseController>();
  final listExercise = <ExerciseModel>[].obs;

  void fetchExercise() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider.getContent(courseId: courseController.course.courseId,
        categoryId: category.categoryId,
        categoryType: 3).catchError((err) => Notify.error(err));
    if (result != null) {
      listExercise.value = result;
    }
  }

  @override
  void onInit() async {
    fetchExercise();
    // TODO: implement onInit
    super.onInit();
  }
}
