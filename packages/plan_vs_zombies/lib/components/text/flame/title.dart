import 'dart:ui' hide TextStyle;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class Title extends SpriteComponent with HasGameRef {
  var text;
  var positionX = 0.0, positionY = 0.0;
  Title(this.positionX, this.positionY, this.text)
      : super(size: Vector2(301.w, 83.h));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // TODO 1
    sprite = await gameRef.loadSprite('$assetsPath/images/red-title.png');
    anchor = Anchor.center;
    position = Vector2(positionX, positionY);

    final style = TextStyle(
        fontSize: 30.sp,
        fontFamily: 'packages/plan_vs_zombies/Mali',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.white);
    final regular = TextPaint(style: style);

    add(TextComponent(
      text: text,
      textRenderer: regular,
    )
      ..anchor = Anchor.center
      ..x = size.x / 2
      ..y = size.y / 2);
  }
}
