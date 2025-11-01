import 'package:dotted_border/dotted_border.dart';
import 'package:futurekids/modules/exercise/ex_matching/widgets/answer_matching_item.dart';
import 'package:futurekids/modules/exercise/ex_matching/widgets/explain_matching_item.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../utils/config.dart';
import '../widgets/answer_explain.dart';
import 'ex_matching_controller.dart';
import 'widgets/question_matching_item.dart';

class ExMatchingView extends StatelessWidget {
  final controller = Get.put(ExMatchingController());

  ExMatchingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 48,
          child: Obx(() => Text(
                controller.title.value,
                style: CustomTheme.semiBold(16),
              )),
        ),
        Expanded(
            child: ScrollablePositionedList.builder(
                itemScrollController: controller.scrollController,
                padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                itemBuilder: (context, itemIndex) {
                  if (itemIndex == 0) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: kWidthMobile),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                controller.exController.listQuestion.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              ///Câu hỏi là chữ, trả lời là chữ
                              if (controller.exController.listQuestion[index]
                                          .questionType ==
                                      "1" &&
                                  controller.exController.listQuestion[index]
                                          .answerType ==
                                      "1") {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${index + 1}. ${controller.exController.listQuestion[index].question.first.question}',
                                      style: CustomTheme.semiBold(16),
                                    ),
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () =>
                                              controller.onSelectAnswer1(
                                                  questionIndex: index),
                                          child: BoxBorderGradient(
                                            borderSize: 3,
                                            gradientType:
                                                GradientType.accentGradient,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            width: double.infinity,
                                            constraints: const BoxConstraints(
                                              minHeight: 55,
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(() => controller
                                                          .listQuestions.isEmpty
                                                      ? const SizedBox()
                                                      : controller
                                                                  .listQuestions[
                                                                      index]
                                                                  .selectedAnswer ==
                                                              null
                                                          ? Text(
                                                              'Chọn đáp án',
                                                              style: CustomTheme
                                                                      .medium(
                                                                          16)
                                                                  .copyWith(
                                                                      color:
                                                                          kNeutral3Color),
                                                            )
                                                          : Text(
                                                              '${controller.listQuestions[index].selectedAnswer.answer.first.answer}',
                                                              style: CustomTheme
                                                                  .semiBold(
                                                                      16))),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(() => Visibility(
                                            visible: controller
                                                        .listQuestions[index]
                                                        .selectedAnswer !=
                                                    null &&
                                                !controller.isAnswered.value,
                                            child: Positioned(
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () =>
                                                      controller.onRemoveAnswer(
                                                          questionIndex: index),
                                                  child: Image.asset(
                                                    'assets/icons/close_accent.png',
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ))))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    )
                                  ],
                                );
                              }

                              ///Dạng khác
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        BoxBorderGradient(
                                          width: 160,
                                          constraints: const BoxConstraints(
                                              minHeight: 120),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSize: 3,
                                          gradientType:
                                              GradientType.accentGradient,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: Center(
                                              child: QuestionMatchingItem(
                                                  index: index),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Text(
                                            '${index + 1}.',
                                            style: CustomTheme.semiBold(18),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () => controller
                                                      .listQuestions[index]
                                                      .answerType ==
                                                  "1"
                                              ? controller.onSelectAnswer1(
                                                  questionIndex: index)
                                              : controller.onSelectAnswer2(
                                                  questionIndex: index),
                                          child: DottedBorder(
                                            color: kNeutral2Color,
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(12),
                                            dashPattern: const [4, 4],
                                            strokeWidth: 4,
                                            padding: EdgeInsets.zero,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                width: 160,
                                                constraints:
                                                    const BoxConstraints(
                                                        minHeight: 114),
                                                color: Colors.white,
                                                child: Center(
                                                    child: Obx(
                                                  () => controller
                                                              .listQuestions[
                                                                  index]
                                                              .selectedAnswer !=
                                                          null
                                                      ? AnswerMatchingItem(
                                                          index: index)
                                                      : Text(
                                                          'Chọn đáp án',
                                                          style: CustomTheme
                                                                  .medium(16)
                                                              .copyWith(
                                                                  color:
                                                                      kNeutral3Color),
                                                        ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(() => Visibility(
                                            visible: controller
                                                        .listQuestions[index]
                                                        .selectedAnswer !=
                                                    null &&
                                                !controller.isAnswered.value,
                                            child: Positioned(
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () =>
                                                      controller.onRemoveAnswer(
                                                          questionIndex: index),
                                                  child: Image.asset(
                                                    'assets/icons/close_accent.png',
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ))))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    );
                  }

                  if (itemIndex == 1) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        constraints:
                            const BoxConstraints(maxWidth: kWidthMobile),
                        child: _boxExplain(),
                      ),
                    );
                  }

                  if (itemIndex == 2) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Obx(() => KButton(
                              style: CustomTheme.semiBold(16).copyWith(
                                  color: controller.isCompleted.value
                                      ? Colors.white
                                      : kNeutral2Color),
                              onTap: () => controller.isAnswered.value
                                  ? controller.submitData()
                                  : controller.checkCorrect(),
                              width: 328,
                              title: controller.isAnswered.value
                                  ? 'Tiếp theo'
                                  : 'Kiểm tra',
                              backgroundColor: controller.isCompleted.value
                                  ? BackgroundColor.primary
                                  : BackgroundColor.disable,
                            )),
                      ),
                    );
                  }

                  return const SizedBox();
                },
                // separatorBuilder: (context, index) => const SizedBox(height: 16,),
                itemCount: 3)),
      ],
    );
  }

  Widget _boxExplain() {
    return Obx(() => Visibility(
        visible: controller.isAnswered.value,
        child: AnswerExplain(
            isCorrect: true,
            content: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: controller.listQuestions[index]
                                          .isCorrectSelected ??
                                      false
                                  ? const Color(0xFF22f02a)
                                  : const Color(0xFFec1c24)),
                          borderRadius: BorderRadius.circular(12)),
                      child: ExplainMatchingItem(
                        index: index,
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                itemCount: controller.listQuestions.length))));
  }
}
