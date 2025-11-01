import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class AnswerMath extends StatelessWidget {
  final String answer;
  final Function() onTap;
  final bool isSelected;
  final int indexAnswer;
  final int status;
  final bool isCorrect;

  const AnswerMath(
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

    return FractionallySizedBox(
      widthFactor: context.responsive(mobile: 0.5, desktop: 0.25),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: status == 1 ? null : onTap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
              child: BoxBorderGradient(
                gradientType: GradientType.accentGradient,
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.all(1),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 8, top: 8, bottom: 56, right: 8),
                  constraints: const BoxConstraints(
                    minHeight: 140,
                  ),
                  child: Center(
                    child: Math.tex(
                      answer,
                      textStyle: CustomTheme.semiBold(24),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 24,
              child: Image.asset(
                'assets/icons/character_$indexAnswer.png',
                width: 32,
              ))
        ],
      ),
    );
  }
}
