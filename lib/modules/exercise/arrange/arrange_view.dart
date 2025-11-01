import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/components/question_book/question_book_view.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../widgets/answer_explain.dart';
import 'arrange_controller.dart';

class ArrangeView extends StatelessWidget {
  late final ArrangeController controller;
  final QuestionModel model;

  ArrangeView({Key? key, required this.model}) : super(key: key) {
    controller = Get.put(ArrangeController(), tag: model.contentId.toString());
    controller.initData(answers: model.answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollablePositionedList.builder(
        itemScrollController: controller.itemScrollController,
        itemCount: 3,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        itemBuilder: (context, index) {
          ///câu hỏi
          if (index == 0) {
            return Align(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 867),
                child: _boxQuestion(context),
              ),
            );
          }

          /// câu trả lời
          if (index == 1) {
            return Align(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 867),
                child: _boxAnswer(),
              ),
            );
          }

          /// giải thích
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
                    onTap: () => controller.listAnswerRandom.isNotEmpty
                        ? null
                        : controller.status.value == 0
                            ? controller.onCheckAnswer(point: model.point)
                            : controller.onNext(),
                    width: 328,
                    title:
                        controller.status.value == 0 ? 'Kiểm tra' : 'Tiếp theo',
                    style: CustomTheme.semiBold(16).copyWith(
                        color: controller.listAnswerRandom.isEmpty
                            ? Colors.white
                            : kNeutral2Color),
                    backgroundColor: controller.listAnswerRandom.isEmpty
                        ? BackgroundColor.primary
                        : BackgroundColor.disable,
                  )))
        ],
      ),
    );
  }

  Widget _boxQuestion(BuildContext context) {
    return QuestionBookView(
      listContent: model.question,
      tag: model.contentId.toString(),
      child: Padding(
        padding:
            EdgeInsets.only(top: context.responsive(mobile: 16, desktop: 60)),
        child: Container(
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 70),
          decoration: BoxDecoration(
              color: kNeutral4Color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Obx(() => Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 4,
                  runSpacing: 8,
                  children: [
                    ...List.generate(
                        controller.listAnswer.length,
                        (index) => InkWell(
                              onTap: () {
                                if (controller.status.value == 0) {
                                  controller.listAnswerRandom
                                      .add(controller.listAnswer[index]);
                                  controller.listAnswer.removeAt(index);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    height: 55,
                                    constraints:
                                        const BoxConstraints(minWidth: 60),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: const Color(0xFFFFC200)),
                                        color: Colors.white),
                                    child: Center(
                                      child: Text(controller.listAnswer[index],
                                          style: CustomTheme.semiBold(16)),
                                    ),
                                  )
                                ],
                              ),
                            )),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _boxAnswer() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Obx(() => Wrap(
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 8,
            children: [
              ...List.generate(
                  controller.listAnswerRandom.length,
                  (index) => GestureDetector(
                        onTap: () {
                          controller.listAnswer
                              .add(controller.listAnswerRandom[index]);
                          controller.listAnswerRandom.removeAt(index);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 55,
                              constraints: const BoxConstraints(minWidth: 60),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xFFFFC200)),
                                  color: Colors.white),
                              child: Center(
                                child: Text(controller.listAnswerRandom[index],
                                    style: CustomTheme.semiBold(16)),
                              ),
                            )
                          ],
                        ),
                      )),
            ],
          )),
    );
  }

  Widget _boxExplain() {
    return Obx(() => Visibility(
          visible: controller.status.value == 1,
          child: AnswerExplain(
              isCorrect: listEquals(
                  controller.listCorrectAnswer, controller.listAnswer),
              correctAnswer: null,
              explain: model.explainAnswer),
        ));
  }
}
