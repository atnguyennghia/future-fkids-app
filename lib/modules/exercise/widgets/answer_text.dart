import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';

class AnswerText extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool isSelected;
  final int indexAnswer;
  final int status;
  final bool isCorrect;

  const AnswerText(
      {Key? key,
      required this.indexAnswer,
      required this.answer,
      required this.onTap,
      required this.isSelected,
      required this.status,
      required this.isCorrect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    if (status == 0) {
      if (isSelected) {
        color = const Color(0xFFFFC200);
      } else {
        color = Colors.white;
      }
    }

    if (status == 1) {
      if (isCorrect) {
        color = const Color(0xFF00AD07);
      } else {
        if (isSelected) {
          color = const Color(0xFFEC1C24);
        } else {
          color = Colors.white;
        }
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: status == 1 ? null : onTap,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 16,
                left: context.responsive(mobile: 0, desktop: 8),
                right: context.responsive(mobile: 0, desktop: 8)),
            child: BoxBorderGradient(
              gradientType: GradientType.accentGradient,
              padding: const EdgeInsets.all(1),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(22)),
                padding: const EdgeInsets.only(
                    left: 60, top: 8, bottom: 8, right: 8),
                constraints: BoxConstraints(
                    minHeight: 60,
                    maxWidth: context.responsive(
                        mobile: double.infinity, desktop: 320)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(answer, style: CustomTheme.semiBold(16)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 16,
            left: 16,
            child: Image.asset(
              'assets/icons/character_$indexAnswer.png',
              width: 32,
            ))
      ],
    );
  }
}
