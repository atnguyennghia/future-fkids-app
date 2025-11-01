import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/ex_other/ex_other_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/helper.dart';
import '../../../utils/loading_dialog.dart';

class TypingController extends GetxController {
  final exOtherController = Get.find<ExOtherController>();
  final itemScrollController = ItemScrollController();

  QuestionModel model;

  List<dynamic> listAnswer = [];

  final isCompleted = false.obs;
  final status = 0.obs;

  TypingController({required this.model}) {
    listAnswer = List.generate(model.answer.length, (index) => {});
  }

  String getAnswerFraction(String tuSo, String mauSo) {
    String result = '';
    result = '[';
    result += r'"' + tuSo + r'",';
    result += r'"' + mauSo + r'"';
    result += ']';
    return result;
  }

  String getAnswerMixed(String honSo, String tuSo, String mauSo) {
    String result = '';
    result = '[';
    result += r'"' + honSo + r'",';
    result += r'"' + tuSo + r'",';
    result += r'"' + mauSo + r'"';
    result += ']';
    return result;
  }

  void checkCompleted() {
    for (var item in listAnswer) {
      if (item.isEmpty) {
        isCompleted.value = false;
        return;
      }
    }
    isCompleted.value = true;
  }

  void checkCompletedFraction() {
    for (var item in listAnswer) {
      if (item["tuSo"] == null ||
          item["mauSo"] == null ||
          item["tuSo"].toString().isEmpty ||
          item["mauSo"].toString().isEmpty) {
        isCompleted.value = false;
        return;
      }
    }
    isCompleted.value = true;
  }

  void checkCompletedMixed() {
    for (var item in listAnswer) {
      if (item["honSo"] == null ||
          item["tuSo"] == null ||
          item["mauSo"] == null ||
          item["honSo"].toString().isEmpty ||
          item["tuSo"].toString().isEmpty ||
          item["mauSo"].toString().isEmpty) {
        isCompleted.value = false;
        return;
      }
    }
    isCompleted.value = true;
  }

  void onCheckAnswer({required dynamic point}) async {
    ///hiển thị popup đúng/sai
    final dialog = LoadingDialog();
    dialog.show();

    if (checkCorrect()) {
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

  bool checkCorrect() {
    if (model.answer.first.type == '1') {
      for (int i = 0; i < listAnswer.length; i++) {
        if (Helper.instance.cleanupWhitespace(
                model.answer[i].answer.toString().trim().toLowerCase()) !=
            Helper.instance.cleanupWhitespace(
                listAnswer[i].toString().trim().toLowerCase())) {
          return false;
        }
      }
    }
    if (model.answer.first.type == '2') {
      for (int i = 0; i < listAnswer.length; i++) {
        if (model.answer[i].answer.toString().trim().toLowerCase() !=
            getAnswerFraction(
                listAnswer[i]["tuSo"].toString().trim().toLowerCase(),
                listAnswer[i]["mauSo"].toString().trim().toLowerCase())) {
          return false;
        }
      }
    }
    if (model.answer.first.type == '3') {
      for (int i = 0; i < listAnswer.length; i++) {
        if (model.answer[i].answer.toString().trim().toLowerCase() !=
            getAnswerMixed(
                listAnswer[i]["honSo"].toString().trim().toLowerCase(),
                listAnswer[i]["tuSo"].toString().trim().toLowerCase(),
                listAnswer[i]["mauSo"].toString().trim().toLowerCase())) {
          return false;
        }
      }
    }

    return true;
  }
}
