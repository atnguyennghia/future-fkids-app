import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/components/long_content/long_content_view.dart';
import 'package:futurekids/modules/exercise/components/question_book/question_book_view.dart';
import 'package:futurekids/modules/exercise/components/video/video_view.dart';
import 'package:futurekids/modules/exercise/widgets/answer_audio.dart';
import 'package:futurekids/modules/exercise/widgets/answer_explain.dart';
import 'package:futurekids/modules/exercise/widgets/answer_image.dart';
import 'package:futurekids/modules/exercise/widgets/answer_math.dart';
import 'package:futurekids/modules/exercise/widgets/answer_text.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'select_controller.dart';

class SelectView extends StatelessWidget {
  late final SelectController controller;
  final QuestionModel model;

  SelectView({Key? key, required this.model}) : super(key: key) {
    controller = Get.put(SelectController(), tag: model.contentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollablePositionedList.builder(
        itemScrollController: controller.scrollController,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        itemCount: 3,
        itemBuilder: (context, indexItem) {
          if (indexItem == 0) {
            return Align(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 867),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.responsive(mobile: 0, desktop: 32)),
                  child: _boxQuestion(),
                ),
              ),
            );
          }

          if (indexItem == 1) {
            return Align(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 867),
                child: _boxAnswer(),
              ),
            );
          }

          if (indexItem == 2) {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 867),
                child: _boxExplain(),
              ),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Obx(() => KButton(
                    onTap: () => controller.selectedAnswerIndex.value == 99
                        ? null
                        : controller.status.value == 0
                            ? controller.onCheckAnswer(
                                isCorrect: model.correctAnswer ==
                                    controller.selectedAnswerIndex.value,
                                point: model.point)
                            : controller.onNext(),
                    title:
                        controller.status.value == 0 ? 'Kiểm tra' : 'Tiếp theo',
                    style: CustomTheme.semiBold(16).copyWith(
                        color: controller.selectedAnswerIndex.value != 99
                            ? Colors.white
                            : kNeutral2Color),
                    width: 328,
                    backgroundColor: controller.selectedAnswerIndex.value == 99
                        ? BackgroundColor.disable
                        : BackgroundColor.primary,
                  )))
        ],
      ),
    );
  }

  Widget _boxQuestion() {
    return model.question[0].type == "3"
        ? //video
        VideoView(
            videoUrl: model.question[0].question,
            tag: model.contentId.toString())
        : model.question[0].type == "5"
            ? //Nội dung dài
            LongContentView(
                content: model.question, tag: model.contentId.toString())
            : QuestionBookView(
                listContent: model.question, tag: model.contentId.toString());
  }

  Widget _boxAnswer() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Obx(() => Wrap(
            children: [
              ...List.generate(model.answer.length, (indexAnswer) {
                switch (model.answerType) {
                  case "1":
                    return AnswerText(
                      indexAnswer: indexAnswer,
                      answer: model.answer[indexAnswer].answer,
                      onTap: () {
                        controller.selectedAnswerIndex.value = indexAnswer;
                      },
                      isSelected:
                          controller.selectedAnswerIndex.value == indexAnswer,
                      status: controller.status.value,
                      isCorrect: model.correctAnswer == indexAnswer,
                    );
                  case "2":
                    return AnswerImage(
                      indexAnswer: indexAnswer,
                      answer: model.answer[indexAnswer].answer,
                      onTap: () {
                        controller.selectedAnswerIndex.value = indexAnswer;
                      },
                      isSelected:
                          controller.selectedAnswerIndex.value == indexAnswer,
                      status: controller.status.value,
                      isCorrect: model.correctAnswer == indexAnswer,
                    );
                  case "3":
                    return AnswerAudio(
                      indexAnswer: indexAnswer,
                      answer: model.answer[indexAnswer].answer,
                      onTap: () {
                        controller.selectedAnswerIndex.value = indexAnswer;
                      },
                      isSelected:
                          controller.selectedAnswerIndex.value == indexAnswer,
                      status: controller.status.value,
                      isCorrect: model.correctAnswer == indexAnswer,
                      tag: 'answer_${model.contentId}_$indexAnswer',
                    );
                  case "4":
                    return AnswerMath(
                      indexAnswer: indexAnswer,
                      answer: model.answer[indexAnswer].answer,
                      onTap: () {
                        controller.selectedAnswerIndex.value = indexAnswer;
                      },
                      isSelected:
                          controller.selectedAnswerIndex.value == indexAnswer,
                      status: controller.status.value,
                      isCorrect: model.correctAnswer == indexAnswer,
                    );
                  default:
                    return const SizedBox();
                }
              })
            ],
          )),
    );
  }

  Widget _boxExplain() {
    return Obx(() => Visibility(
          visible: controller.status.value == 1,
          child: AnswerExplain(
              isCorrect:
                  model.correctAnswer == controller.selectedAnswerIndex.value,
              correctAnswer: model.correctAnswer,
              explain: model.explainAnswer),
        ));
  }
}
