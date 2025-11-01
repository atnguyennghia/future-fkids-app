import 'package:futurekids/modules/exercise/ex_matching/ex_matching_controller.dart';
import 'package:futurekids/modules/exercise/ex_matching/widgets/answer_matching_item_correct.dart';
import 'package:futurekids/modules/exercise/ex_matching/widgets/question_matching_item.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplainMatchingItem extends StatelessWidget {
  final controller = Get.find<ExMatchingController>();

  final int index;

  ExplainMatchingItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Câu hỏi là chữ, trả lời là chữ
    if (controller.exController.listQuestion[index].questionType == "1" &&
        controller.exController.listQuestion[index].answerType == "1") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}. ${controller.listQuestions[index].question.first.question}',
            style: CustomTheme.semiBold(16),
          ),
          Text(
            '- ${controller.listQuestions[index].answer.first.answer}',
            style: CustomTheme.semiBold(16),
          )
        ],
      );
    }

    ///Cac dang khac
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              constraints: const BoxConstraints(minHeight: 90),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: QuestionMatchingItem(
                  index: index,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 120,
              constraints: const BoxConstraints(minHeight: 90),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: AnswerMatchingItemCorrect(
                  index: index,
                ),
              ),
            )
          ],
        ),
        Positioned(
            top: -8,
            left: -8,
            child: Text(
              '${index + 1}.',
              style: CustomTheme.semiBold(16),
            ))
      ],
    );
  }
}
