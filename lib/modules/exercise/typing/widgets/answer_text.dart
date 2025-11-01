import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/typing/widgets/answer_text_controller.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';

import '../../../../widgets/box_border_gradient.dart';

class AnswerText extends StatelessWidget {
  final Function(String) onChange;
  final AnswerModel answer;
  final int? answerIndex;
  final bool showCharacter;
  final bool readOnly;

  late final AnswerTextController controller;

  AnswerText(
      {Key? key,
      required this.answer,
      required this.onChange,
      required this.answerIndex,
      required this.showCharacter,
      required this.readOnly,
      required dynamic questionId})
      : super(key: key) {
    controller =
        Get.put(AnswerTextController(), tag: '${questionId}_$answerIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Math.tex(
                '${answer.before}',
                textStyle: CustomTheme.semiBold(16),
              ),
            ),
            visible:
                answer.before != null && answer.before.toString().isNotEmpty,
          ),
          Expanded(
            child: Stack(
              children: [
                BoxBorderGradient(
                  borderRadius: BorderRadius.circular(24),
                  padding: const EdgeInsets.all(1),
                  gradientType: GradientType.accentGradient,
                  child: Container(
                    width: double.infinity,
                    constraints:
                        const BoxConstraints(minHeight: 48, maxHeight: 128),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22)),
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.deny('\n')],
                      controller: controller.textEditingController,
                      onChanged: (value) => onChange(value),
                      textAlign: TextAlign.center,
                      style: CustomTheme.semiBold(16),
                      maxLines: null,
                      readOnly: readOnly,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              top: 16,
                              left: showCharacter ? 48 : 16,
                              right: 16,
                              bottom: 16)),
                      keyboardType: controller.isNumber(str: answer.answer)
                          ? GetPlatform.isAndroid
                              ? TextInputType.text
                              : const TextInputType.numberWithOptions(
                                  signed: true, decimal: true)
                          : null,
                    ),
                  ),
                ),
                Visibility(
                    visible: showCharacter,
                    child: Positioned(
                        top: 12,
                        left: 12,
                        child: Image.asset(
                          'assets/icons/character_$answerIndex.png',
                          width: 32,
                        )))
              ],
            ),
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Math.tex(
                '${answer.unit}',
                textStyle: CustomTheme.semiBold(16),
              ),
            ),
            visible: answer.unit != null && answer.unit.toString().isNotEmpty,
          )
        ],
      ),
    );
  }
}
