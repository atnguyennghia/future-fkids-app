import 'package:archery/components/image/widgets/micro.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FuboArchery extends SpriteAnimationComponent {
  var sprites = [
    1,
    2,
    3,
    4,
    5,
  ].map((i) => Sprite.load('$assetsPath/images/fubo-archery-$i.png'));

  var spritesArchery = [6, 6, 6, 6, 6, 5, 4]
      .map((i) => Sprite.load('$assetsPath/images/fubo-archery-$i.png'));

  SpriteAnimation? animationArchery;

  SpriteAnimation? animationRunning;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    animationRunning = SpriteAnimation.spriteList(await Future.wait(sprites),
        stepTime: 0.12, loop: true);
    animation = animationRunning;
    size = Vector2(400.h, 400.h);
    position = Vector2(242.w, 468.h);
    priority = 4;
    removeOnFinish = true;
    playing = true;

    animationArchery = SpriteAnimation.spriteList(
        await Future.wait(spritesArchery),
        stepTime: 0.12,
        loop: true);
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);
    if (Micro.isFinish) {
      animation = animationArchery;
      playing = true;
    } else {
      animation = animationRunning;
      playing = true;
    }
  }
}
