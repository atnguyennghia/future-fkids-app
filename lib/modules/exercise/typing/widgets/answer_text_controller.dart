import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnswerTextController extends GetxController {
  final textEditingController = TextEditingController();

  bool isNumber({dynamic str}) {
    var tmp = str.toString().trim();
    tmp = tmp.replaceAll('.', '');
    tmp = str.replaceAll(',', '');

    return tmp.isNumericOnly;
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
