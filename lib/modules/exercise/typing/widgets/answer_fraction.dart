import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/modules/exercise/typing/widgets/answer_fraction_controller.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';

class AnswerFraction extends StatelessWidget {
  final AnswerModel answer;
  final Function(String) tuSoOnChanged;
  final Function(String) mauSoOnChanged;
  final bool readonly;

  late final AnswerFractionController controller;

  AnswerFraction(
      {Key? key,
      required this.answer,
      required this.tuSoOnChanged,
      required this.mauSoOnChanged,
      required this.readonly,
      required dynamic answerIndex,
      required dynamic questionId})
      : super(key: key) {
    controller =
        Get.put(AnswerFractionController(), tag: '${questionId}_$answerIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Math.tex(
              '${answer.before}',
              textStyle: CustomTheme.semiBold(16),
            ),
          ),
          visible: answer.before != null && answer.before.toString().isNotEmpty,
        ),
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: kNeutral2Color)),
              child: TextField(
                controller: controller.textEditingController1,
                readOnly: readonly,
                onChanged: (value) => tuSoOnChanged(value),
                textAlign: TextAlign.center,
                style: CustomTheme.semiBold(16),
                decoration: const InputDecoration(border: InputBorder.none),
                keyboardType: GetPlatform.isAndroid
                    ? TextInputType.text
                    : const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: kNeutral2Color)),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: kNeutral2Color)),
              child: TextField(
                controller: controller.textEditingController2,
                readOnly: readonly,
                onChanged: (value) => mauSoOnChanged(value),
                textAlign: TextAlign.center,
                style: CustomTheme.semiBold(16),
                decoration: const InputDecoration(border: InputBorder.none),
                keyboardType: GetPlatform.isAndroid
                    ? TextInputType.text
                    : const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
              ),
            ),
          ],
        ),
        Visibility(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            // child: Text('${answer.unit}', style: kTitle32Bold,),
            child: Math.tex(
              '${answer.unit}',
              textStyle: CustomTheme.semiBold(16),
            ),
          ),
          visible: answer.unit != null && answer.unit.toString().isNotEmpty,
        )
      ],
    );
  }
}
