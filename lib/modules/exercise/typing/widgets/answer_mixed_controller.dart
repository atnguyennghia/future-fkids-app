import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnswerMixedController extends GetxController {
  final textEditingController1 = TextEditingController();
  final textEditingController2 = TextEditingController();
  final textEditingController3 = TextEditingController();

  @override
  void onClose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    super.onClose();
  }
}
