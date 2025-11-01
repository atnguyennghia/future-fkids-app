import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/game_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  CategoryModel category;
  GameController({required this.category});
  final courseController = Get.find<CourseController>();
  final listGame = <GameModel>[].obs;

  void fetchGame() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider.getContent(courseId: courseController.course.courseId,
        categoryId: category.categoryId,
        categoryType: 4).catchError((err) => Notify.error(err));
    if (result != null) {
      listGame.value = result;
    }
  }

  @override
  void onInit() {
    fetchGame();
    // TODO: implement onInit
    super.onInit();
  }
}
