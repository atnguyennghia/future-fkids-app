import 'dart:ui';

import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundMicro extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    sprite =
        await gameRef.loadSprite('$assetsPath/images/background-micro.png');
    anchor = Anchor.center;
    position = Vector2(gameRef.size.x / 2, 857.h + 223.h / 2);
    size = Vector2(gameRef.size.x, 223.h);
    priority = 2;

    //add(Micro());

    final style = TextStyle(
        fontSize: 28.sp,
        fontFamily: 'packages/archery/Dongle',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.white);
    final regular = TextPaint(style: style);

    add(TextComponent(
        text: QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'Press the micro and say'
            : 'Nhấn vào mic và nói',
        textRenderer: regular,
        position: Vector2(876.w + 155.w / 2, 40.h))
      ..anchor = Anchor.center
      ..priority = 3);
  }
}
