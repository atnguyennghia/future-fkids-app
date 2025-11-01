import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'long_content_controller.dart';

class LongContentView extends StatelessWidget {
  final List<QuestionContentModel> content;

  late final LongContentController controller;

  LongContentView({Key? key, required this.content, required String tag})
      : super(key: key) {
    controller = Get.put(LongContentController(), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: BoxBorderGradient(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    width: double.infinity,
                    height: controller.isExpand.value ? null : 272,
                    child: SingleChildScrollView(
                      child: HtmlWidget(
                        content[0].question,
                        textStyle: CustomTheme.medium(16),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 20),
                ),
                Positioned(
                    bottom: -4,
                    child: Transform.scale(
                      scale: 0.75,
                      child: KButton(
                        onTap: () => controller.isExpand.value =
                            !controller.isExpand.value,
                        title:
                            controller.isExpand.value ? "Thu gọn" : 'Xem thêm',
                        style: CustomTheme.medium(16),
                        width: 112,
                        suffixIcon: Icon(
                          controller.isExpand.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ...List.generate(content.length, (indexQuestion) {
              if (indexQuestion == 0) {
                return Container();
              }
              final question = content[indexQuestion];
              if (question.type == "1") {
                return HtmlWidget(
                  question.question,
                  textStyle: CustomTheme.medium(16),
                );
              }
              if (question.type == "2") {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    child: Image.asset(
                      'assets/icons/loa.png',
                      width: 40,
                      height: 40,
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                );
              }
              if (question.type == "4") {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Math.tex(question.question),
                );
              }
              return Container();
            }),
          ],
        ));
  }
}
