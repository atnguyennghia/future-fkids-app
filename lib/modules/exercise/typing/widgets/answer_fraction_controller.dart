import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnswerFractionController extends GetxController {
  final textEditingController1 = TextEditingController();
  final textEditingController2 = TextEditingController();

  @override
  void onClose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.onClose();
  }
}
