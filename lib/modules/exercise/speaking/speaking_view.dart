import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/modules/exercise/components/question_book/question_book_view.dart';
import 'package:futurekids/modules/exercise/components/video/video_view.dart';
import 'package:futurekids/modules/exercise/speaking/widgets/speaking_result.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/score_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/config.dart';
import 'speaking_controller.dart';

class SpeakingView extends StatelessWidget {
  late final SpeakingController controller;

  SpeakingView({Key? key, required QuestionModel model}) : super(key: key) {
    controller = Get.put(SpeakingController(model: model),
        tag: model.contentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollablePositionedList.separated(
          itemScrollController: controller.scrollController,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
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

            ///Kết quả
            if (index == 2) {
              return Align(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: kWidthMobile),
                  child: _boxExplain(),
                ),
              );
            }

            return const SizedBox();
          }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _toolBar(),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => Visibility(
                        visible: controller.isCompleted.value,
                        child: KButton(
                          onTap: () => controller.onNext(),
                          title: 'Tiếp theo',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: Colors.white),
                          width: 328,
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }

  Widget _boxQuestion() {
    return controller.model.question.first.type == "3"
        ? //Neu cau hoi là video
        VideoView(
            videoUrl: controller.model.question.first.question,
            tag: controller.model.contentId.toString())
        : QuestionBookView(
            listContent: controller.model.question,
            tag: controller.model.contentId.toString(),
            child: controller.getTypeAnswerDisplay() == 1
                ? Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      controller.audioQuestionPath.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AudioView(
                                  fromURI: controller.audioQuestionPath,
                                  tag: controller.model.contentId.toString()),
                            )
                          : const SizedBox(),
                      Obx(
                        () => controller.isCompleted.value
                            ? _highlightAnswer()
                            : Text(
                                '${controller.model.answer.first.answer}',
                                style: CustomTheme.semiBold(16),
                              ),
                      )
                    ],
                  )
                : null);
  }

  Widget _boxAnswer() {
    return controller.getTypeAnswerDisplay() == 2
        ? Column(
            children: [
              Text(
                'Đọc cả câu trả lời với các từ gợi ý sau',
                style: CustomTheme.semiBold(16).copyWith(color: kNeutral2Color),
              ),
              const SizedBox(
                height: 8,
              ),
              BoxBorderGradient(
                gradientType: GradientType.accentGradient,
                borderRadius: BorderRadius.circular(24),
                padding: const EdgeInsets.all(1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 56),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(
                    children: [
                      controller.audioQuestionPath.isNotEmpty
                          ? AudioView(
                              fromURI: controller.audioQuestionPath,
                              tag: controller.model.contentId.toString())
                          : const SizedBox(),
                      Expanded(
                          child: Obx(() => Center(
                              child: controller.isCompleted.value
                                  ? _highlightAnswer()
                                  : Text(
                                      controller.listDisplay.join(' '),
                                      style: CustomTheme.semiBold(16),
                                    ))))
                    ],
                  ),
                ),
              )
            ],
          )
        : controller.getTypeAnswerDisplay() == 3
            ? Obx(() => Visibility(
                visible: controller.isCompleted.value,
                child: Column(
                  children: [
                    Text(
                      'Đáp án',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    BoxBorderGradient(
                      gradientType: GradientType.accentGradient,
                      borderRadius: BorderRadius.circular(24),
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 56),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          children: [
                            controller.audioQuestionPath.isNotEmpty
                                ? AudioView(
                                    fromURI: controller.audioQuestionPath,
                                    tag: controller.model.contentId.toString())
                                : const SizedBox(),
                            Expanded(
                                child: Obx(() => Center(
                                    child: controller.isCompleted.value
                                        ? _highlightAnswer()
                                        : Text(
                                            controller.listAnswer.join(' '),
                                            style: CustomTheme.semiBold(16),
                                          ))))
                          ],
                        ),
                      ),
                    )
                  ],
                )))
            : controller.model.question.first.type == "3"
                ? Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 44),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: HtmlWidget(
                                    controller.model.question[1].question,
                                    textStyle: CustomTheme.semiBold(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 16,
                              child: SvgPicture.asset(
                                  'assets/icons/triangle_1.svg'))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(minHeight: 44),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: controller.isCompleted.value
                                      ? _highlightAnswer()
                                      : Text(controller.listDisplay.join(' '),
                                          style: CustomTheme.semiBold(16)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 16,
                              child: SvgPicture.asset(
                                  'assets/icons/triangle_2.svg'))
                        ],
                      ),
                    ],
                  )
                : const SizedBox();
  }

  Widget _boxExplain() {
    return Obx(() => Visibility(
        visible: controller.isCompleted.value,
        child: SpeakingResult(percent: controller.percentComplete)));
  }

  Widget _toolBar() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Visibility(
              visible: controller.isCompleted.value,
              child: ScoreStar(
                totalPoint: controller.totalPoint.round(),
                point: controller.point,
                width: 65,
                height: 65,
              ))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Obx(() => Column(
                  children: [
                    Visibility(
                        visible: !controller.isSpeaking.value,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Nhấn vào mic và nói',
                            style: CustomTheme.semiBold(16)
                                .copyWith(color: kNeutral2Color),
                          ),
                        )),
                    //
                    InkWell(
                      onTap: () => controller.onSpeaking(),
                      child: Image.asset(
                        controller.isSpeaking.value
                            ? 'assets/icons/micro.gif'
                            : 'assets/icons/micro.png',
                        width: 100,
                      ),
                    )
                  ],
                )),
          ),
          Obx(() => Visibility(
              visible: controller.isCompleted.value,
              child: AudioView(
                fromURI: controller.mPath,
                tag: '${controller.model.contentId}_2',
                width: 65,
                height: 65,
              )))
        ],
      ),
    );
  }

  Widget _highlightAnswer() {
    return RichText(
      text: TextSpan(
          children: List.generate(controller.listAnswer.length, (index) {
            try {
              final listCharAnswer = controller.listAnswer[index].split('');
              final listCharRecognize =
                  controller.listRecognize[index].split('');
              return TextSpan(
                  text: index == 0 ? '' : ' ',
                  children: List.generate(listCharAnswer.length, (indexChar) {
                    try {
                      if (listCharAnswer[indexChar].toLowerCase() ==
                          listCharRecognize[indexChar].toLowerCase()) {
                        return TextSpan(
                            text: listCharAnswer[indexChar],
                            style: const TextStyle(color: Color(0xFF00BC08)));
                      }
                    } catch (_) {}
                    return TextSpan(text: listCharAnswer[indexChar]);
                  }));
            } catch (_) {}
            return TextSpan(
                text: index == 0
                    ? controller.listAnswer[index]
                    : ' ' + controller.listAnswer[index]);
          }),
          style: CustomTheme.semiBold(16).copyWith(color: kPrimaryColor)),
    );
  }
}
