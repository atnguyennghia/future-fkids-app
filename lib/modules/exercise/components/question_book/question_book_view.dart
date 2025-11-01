import 'package:dotted_border/dotted_border.dart';
import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'question_book_controller.dart';

class QuestionBookView extends StatelessWidget {
  late final QuestionBookController controller;
  final String tag;
  final Widget? child;

  QuestionBookView(
      {Key? key,
      required List<QuestionContentModel> listContent,
      required this.tag,
      this.child})
      : super(key: key) {
    controller =
        Get.put(QuestionBookController(listContent: listContent), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: kNeutral3Color,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [4, 4],
      strokeWidth: 2,
      padding: const EdgeInsets.all(1),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
            minHeight: context.responsive(mobile: 144, desktop: 340)),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...List.generate(controller.listQuestionContent.length, (index) {
            switch (controller.listQuestionContent[index].type) {
              case "1":
                return HtmlWidget(
                    controller.listQuestionContent[index].question,
                    textStyle: CustomTheme.semiBold(16),
                    customWidgetBuilder: (element) {
                  if (element.localName == 'img') {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          element.attributes['src']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }

                  return null;
                });
              case "2":
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: AudioView(
                      fromURI: controller.listQuestionContent[index].question,
                      tag: 'question_${tag}_$index'),
                );
              case "4":
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Math.tex(
                    controller.listQuestionContent[index].question,
                    textStyle: CustomTheme.semiBold(16),
                  ),
                );
              default:
                return const SizedBox();
            }
          }),
          child ?? const SizedBox()
        ]),
      ),
    );
  }
}
