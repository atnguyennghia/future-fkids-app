import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/ex_other/ex_other_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/loading_dialog.dart';

class ArrangeController extends GetxController {
  final listAnswer = <String>[].obs;
  final listAnswerRandom = <String>[].obs;
  List<String> listCorrectAnswer = [];

  bool isInit = false;

  final status = 0.obs;

  final exOtherController = Get.find<ExOtherController>();
  final itemScrollController = ItemScrollController();

  void onCheckAnswer({required dynamic point}) async {
    ///hiển thị popup đúng/sai
    final dialog = LoadingDialog();
    dialog.show();

    if (listEquals(listCorrectAnswer, listAnswer)) {
      exOtherController.point += point;
      exOtherController.numberOfCorrect += 1;
      dialog.correct();
    } else {
      dialog.inCorrect();
    }

    await Future.delayed(const Duration(seconds: 2));
    dialog.dismiss();

    ///cập nhật đã trả lời câu hỏi
    status.value = 1;

    ///hiển thị giải thích
    itemScrollController.jumpTo(index: 2);
  }

  void onNext() {
    exOtherController.onNext();
  }

  void initData({required List<AnswerModel> answers}) {
    if (!isInit) {
      for (var item in answers) {
        listCorrectAnswer.add(item.answer);
        listAnswerRandom.add(item.answer);
      }
      listAnswerRandom.shuffle();
      isInit = true;
    }
  }
}
