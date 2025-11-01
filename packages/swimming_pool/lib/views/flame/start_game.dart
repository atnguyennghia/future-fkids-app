import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class StartGameSwimmingPool extends FlameGame {
  static const ID = "StartGameSwimmingPool";
  static Bgm audio = Bgm();

  void startBgmMusic() {
    audio.initialize();
    audio.play('audio/background-swimming-pool.mp3', volume: 0.1);
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
      ..sprite = await loadSprite('$assetsPath/images/background-start.png')
      ..size = size;

    add(background);

    //add(IconBack(107.w / 2 + 40.w, 108.h / 2 + 40.h, 'icon-back.png'));
    // add(IconCustom(187.w + 107.w / 2, 108.h / 2 + 40.h, 'icon-volume-on.png'));
    // add(ImageLoad(1679.w + 173.w / 2, 33.h + 114.h / 2, 173.w, 114.h,
    //     'future-kids.png', 1));
    //
    // add(ImageLoad(135.w + 421.w / 2, 382.h + 635.h / 2, 421.w, 635.h,
    //     'fubo-start.png', 1));
    //
    // add(ImageLoad(556.w + 1270.w / 2, 240.h + 531.h / 2, 1270.w, 531.h,
    //     'logo.png', 1));

    final style = TextStyle(
      fontSize: 53.sp,
      fontFamily: 'packages/swimming_pool/Mali',
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: Colors.white,
      shadows: const [
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 1.5,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    );
    final regular = TextPaint(style: style);

    add(TextComponent(
        text: '00:00',
        textRenderer: regular,
        position: Vector2(481.w + 25.w, 57.h))
      ..anchor = Anchor.topLeft);
  }
}
