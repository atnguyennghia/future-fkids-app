import 'package:futurekids/modules/exercise/exercise_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExOtherController extends GetxController {
  final exController = Get.find<ExerciseController>();
  final indicatorController = ItemScrollController();
  final pageController = PageController();
  final selectedIndex = 0.obs;

  double point = 0.0;
  int numberOfCorrect = 0;

  void onNext() {
    final itemCount = exController.listQuestion.length;

    ///Câu cuối cùng
    if (selectedIndex.value == itemCount - 1) {
      exController.submitData(point: point, numberOfCorrect: numberOfCorrect);
      return;
    }

    ///Chuyển sang câu tiếp theo
    selectedIndex.value = selectedIndex.value + 1;

    pageController.animateToPage(selectedIndex.value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

    if (selectedIndex.value >= 0 && selectedIndex.value < 10 ||
        selectedIndex.value >= itemCount - 5 &&
            selectedIndex.value < itemCount) {
      return;
    }

    indicatorController.scrollTo(
        index: selectedIndex.value,
        alignment: 0.5,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
