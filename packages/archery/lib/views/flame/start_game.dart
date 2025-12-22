import 'dart:ui';

import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartGameArchery extends FlameGame {
  static const ID = "StartGameArchery";
  static Bgm audio = Bgm();

  Future<void> startBgmMusic() async {
    audio.initialize();
    //Access thư mục audio bên ngoài
    audio.play('audio/background-archery.mp3', volume: 0.1);
  }

  static Future<void> stopBgmMusic() async {
    audio.stop();
    audio.dispose();
  }

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    startBgmMusic();

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('$assetsPath/images/background-final.png')
      ..size = size
      ..position = Vector2.zero();

    add(background);

    final style = TextStyle(
        fontSize: 53.sp,
        fontFamily: 'packages/archery/Mali',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: Colors.white);
    final regular = TextPaint(style: style);

    add(TextComponent(
        text: '00:00',
        textRenderer: regular,
        position: Vector2(481.w + 25.w, 57.h))
      ..anchor = Anchor.topLeft);
  }
}
