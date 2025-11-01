import 'package:futurekids/modules/exercise/ex_other/ex_other_controller.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/loading_dialog.dart';

class SelectController extends GetxController {
  final exOtherController = Get.find<ExOtherController>();
  final scrollController = ItemScrollController();

  final selectedAnswerIndex = 99.obs;
  final status = 0.obs;

  void onCheckAnswer({required bool isCorrect, required dynamic point}) async {
    ///hiển thị popup đúng/sai
    final dialog = LoadingDialog();
    dialog.show();

    if (isCorrect) {
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
    scrollController.jumpTo(index: 2);
  }

  void onNext() {
    exOtherController.onNext();
  }
}
