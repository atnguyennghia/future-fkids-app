import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/exercise_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  final exercise = Get.arguments["exercise"] as ExerciseModel;
  final category = Get.arguments["category"] as CategoryModel;
  final nextExercise = Get.arguments["next_exercise"] as ExerciseModel?;
  final score = Get.arguments["score"];
  final numberOfCorrect = Get.arguments["number_of_correct"];
  final totalQuestion = Get.arguments["total_question"];
  final highestScore = Get.arguments["highest_score"];

  AssetImage image = const AssetImage('assets/backgrounds/result_intro.gif');

  final selectedIndex = 0.obs;

  void changeView() async {
    await Future.delayed(const Duration(seconds: 5));
    selectedIndex.value = 1;
  }

  @override
  void onInit() {
    changeView();
    super.onInit();
  }

  @override
  void onClose() {
    image.evict();
    super.onClose();
  }
}
