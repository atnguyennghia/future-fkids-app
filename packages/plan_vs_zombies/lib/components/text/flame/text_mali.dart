import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMali extends FlameGame {
  var text;
  var positionX = 0.0, positionY = 0.0;
  TextMali(this.positionX, this.positionY, this.text);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final style = TextStyle(
        fontSize: 60.sp,
        fontFamily: 'packages/plan_vs_zombies/Mali',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.white,
        overflow: TextOverflow.ellipsis);
    final regular = TextPaint(style: style);

    add(TextComponent(text: text, textRenderer: regular)
      ..anchor = Anchor.center
      ..x = positionX // size is a property from game
      ..y = positionY);
  }
}
