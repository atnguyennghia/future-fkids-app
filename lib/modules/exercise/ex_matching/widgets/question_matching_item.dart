import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/modules/exercise/ex_matching/ex_matching_controller.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionMatchingItem extends StatelessWidget {
  final controller = Get.find<ExMatchingController>();
  final int index;

  QuestionMatchingItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.listQuestions[index].questionType == "1") {
      return Text(
        '${controller.listQuestions[index].question.first.question}',
        style: CustomTheme.semiBold(16),
      );
    }
    if (controller.listQuestions[index].questionType == "2") {
      return SizedBox(
        width: 90,
        height: 90,
        child: Image.network(
          '${controller.listQuestions[index].question.first.question}',
          fit: BoxFit.contain,
        ),
      );
    }
    if (controller.listQuestions[index].questionType == "3") {
      return AudioView(
        fromURI: '${controller.listQuestions[index].question.first.question}',
        tag: 'question_${controller.listQuestions[index].contentId}_$index',
      );
    }
    return const SizedBox();
  }
}
