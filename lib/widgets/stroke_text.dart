import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';

import '../Utils/color_palette.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final double lineHeight;
  final Color borderColor;
  final double? strokeWidth;
  final TextAlign? textAlign;

  const StrokeText(
      {Key? key,
      this.text = '',
      this.fontSize,
      this.color,
      this.lineHeight = 25,
      this.borderColor = Colors.white,
      this.strokeWidth = 3,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? kPrimaryColor;
    return Stack(
      children: [
        // Stroked text as border.
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize ?? (context.responsive(mobile: 20, desktop: 32)),
            fontWeight: FontWeight.w600,
            height: 1.25,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth!
              ..color = borderColor,
          ),
        ),
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              fontSize:
                  fontSize ?? (context.responsive(mobile: 20, desktop: 32)),
              fontWeight: FontWeight.w600,
              color: color,
              height: 1.25),
        ),
      ],
    );
  }
}
