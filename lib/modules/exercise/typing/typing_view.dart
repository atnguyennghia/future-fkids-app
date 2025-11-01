import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/components/question_book/question_book_view.dart';
import 'package:futurekids/modules/exercise/components/video/video_view.dart';
import 'package:futurekids/modules/exercise/typing/widgets/answer_fraction.dart';
import 'package:futurekids/modules/exercise/typing/widgets/answer_mixed.dart';
import 'package:futurekids/modules/exercise/typing/widgets/answer_text.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../widgets/answer_explain.dart';
import 'typing_controller.dart';

class TypingView extends StatelessWidget {
  late final TypingController controller;

  TypingView({Key? key, required QuestionModel model}) : super(key: key) {
    controller = Get.put(TypingController(model: model),
        tag: model.contentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        key: key,
        backgroundColor: Colors.transparent,
        body: ScrollablePositionedList.builder(
          itemScrollController: controller.itemScrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
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

            if (index == 1) {
              return Align(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 867),
                  child: _boxAnswer(),
                ),
              );
            }

            if (index == 2) {
              return Align(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 867),
                  child: _boxExplain(),
                ),
              );
            }

            ///default
            return const SizedBox();
          },
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
                minimum: const EdgeInsets.all(16),
                child: Obx(() => KButton(
                      onTap: () => !controller.isCompleted.value
                          ? null
                          : controller.status.value == 0
                              ? controller.onCheckAnswer(
                                  point: controller.model.point)
                              : controller.onNext(),
                      width: 328,
                      title: controller.status.value == 0
                          ? 'Kiểm tra'
                          : 'Tiếp theo',
                      style: CustomTheme.semiBold(16).copyWith(
                          color: controller.isCompleted.value
                              ? Colors.white
                              : kNeutral2Color),
                      backgroundColor: controller.isCompleted.value
                          ? BackgroundColor.primary
                          : BackgroundColor.disable,
                    )))
          ],
        ),
      ),
    );
  }

  Widget _boxQuestion() {
    return controller.model.question[0].type == "3"
        ? VideoView(
            videoUrl: controller.model.question[0].question,
            tag: controller.model.contentId.toString())
        : QuestionBookView(
            listContent: controller.model.question,
            tag: controller.model.contentId.toString());
  }

  Widget _boxAnswer() {
    /// truong hop cau tra loi la text
    if (controller.model.answer.first.type == "1") {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text('Đáp án của bạn là',
              style: CustomTheme.semiBold(16).copyWith(
                color: kNeutral2Color,
              )),
          ...List.generate(
              controller.model.answer.length,
              (index) => Obx(() => AnswerText(
                    key: key,
                    answer: controller.model.answer[index],
                    answerIndex: index,
                    onChange: (value) {
                      controller.listAnswer[index] = value;
                      controller.checkCompleted();
                    },
                    readOnly: controller.status.value == 1,
                    showCharacter: controller.model.answer.length > 1,
                    questionId: controller.model.contentId,
                  )))
        ],
      );
    }

    ///truong hop cau tra loi la phan so/hon so
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 40, left: 16, right: 16, bottom: 16),
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 272,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF00B907), width: 3),
                  color: Colors.white),
              child: Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                      controller.model.answer.length,
                      (index) =>
                          Obx(() => controller.model.answer.first.type == "2"
                              ? AnswerFraction(
                                  answer: controller.model.answer[index],
                                  tuSoOnChanged: (value) {
                                    controller.listAnswer[index]["tuSo"] =
                                        value;
                                    controller.checkCompletedFraction();
                                  },
                                  mauSoOnChanged: (value) {
                                    controller.listAnswer[index]["mauSo"] =
                                        value;
                                    controller.checkCompletedFraction();
                                  },
                                  readonly: controller.status.value == 1,
                                  answerIndex: index,
                                  questionId: controller.model.contentId,
                                )
                              : AnswerMixed(
                                  answer: controller.model.answer[index],
                                  honSoOnChanged: (value) {
                                    controller.listAnswer[index]["honSo"] =
                                        value;
                                    controller.checkCompletedMixed();
                                  },
                                  tuSoOnChanged: (value) {
                                    controller.listAnswer[index]["tuSo"] =
                                        value;
                                    controller.checkCompletedMixed();
                                  },
                                  mauSoOnChanged: (value) {
                                    controller.listAnswer[index]["mauSo"] =
                                        value;
                                    controller.checkCompletedMixed();
                                  },
                                  readonly: controller.status.value == 1,
                                  answerIndex: index,
                                  questionId: controller.model.contentId,
                                ))),
                ),
              ),
            ),
            Positioned(
                top: -16,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: SvgPicture.asset(
                            'assets/backgrounds/explain_correct_title.svg')),
                    SizedBox(
                      height: 40,
                      width: 216,
                      child: Center(
                        child: Text(
                          'Điền đáp án',
                          style: CustomTheme.semiBold(18),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget _boxExplain() {
    return Obx(() => Visibility(
          visible: controller.status.value == 1,
          child: AnswerExplain(
              isCorrect: controller.checkCorrect(),
              correctAnswer: null,
              explain: controller.model.explainAnswer),
        ));
  }
}
