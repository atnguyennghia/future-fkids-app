import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/exercise_model.dart';
import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/data/providers/submit_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/modules/course/exercise_list/exercise_list_controller.dart';
import 'package:futurekids/modules/lesson/lesson_controller.dart';
import 'package:futurekids/modules/unit/unit_controller.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

import '../../utils/loading_dialog.dart';

class ExerciseController extends GetxController {
  final exercise = Get.arguments["exercise"] as ExerciseModel;
  final category = Get.arguments["category"] as CategoryModel;
  final courseController = Get.find<CourseController>();
  List<QuestionModel> listQuestion = [];

  ExerciseModel? nextExercise;

  Future<void> fetchQuestion() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListQuestion(exId: exercise.id)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      listQuestion = result;
    }
  }

  void submitData({required double point, required int numberOfCorrect}) async {
    if (!AuthService.to.hasLogin) {
      final dialog = LoadingDialog(dismissAble: true);
      dialog.show();
      dialog.succeed(
          message: 'Hãy đăng nhập để sử dụng\nchức năng này bạn nhé!',
          callback: () {
            dialog.dismiss();
            Get.offAndToNamed('/auth/login');
          },
          title: 'Đăng nhập');
      return;
    }

    final dialog = LoadingDialog();
    dialog.show();

    final provider = SubmitProvider();
    final result = await provider
        .submitData(
            profileId: AuthService.to.profileModel.value.id,
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            contentId: exercise.id,
            point: point,
            percentComplete: 100)
        .catchError((err) {
      dialog.dismiss();
      Notify.error(err);
    });
    if (result != null && result) {
      dialog.dismiss();

      //Cập nhật lại điểm
      exercise.point = point > exercise.point ? point : exercise.point;

      //fetch lại data lesson, unit
      Get.find<LessonController>().fetchLesson();
      Get.find<UnitController>().fetchUnit();

      //Chuyển tới page summary
      Get.offAndToNamed('/exercise/result', arguments: {
        "exercise": exercise,
        "category": category,
        "score": point, //Điểm số đạt được
        "number_of_correct": numberOfCorrect,
        "total_question": listQuestion.length,
        "highest_score": exercise.point, //Điểm số cao nhất
        "next_exercise": nextExercise
      });
    }
  }

  @override
  void onInit() {
    fetchQuestion();
    final _courseExController =
        Get.find<ExerciseListController>(tag: category.categoryId.toString());
    int? _index = _courseExController.selectedIndex ==
            _courseExController.listExercise.length - 1
        ? null
        : _courseExController.selectedIndex + 1;
    if (_index != null) {
      nextExercise = _courseExController.listExercise[_index];
      _courseExController.selectedIndex = _index;
    }
    super.onInit();
  }
}
