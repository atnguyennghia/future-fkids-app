import 'package:archery/components/image/flame/arrow.dart';
import 'package:archery/components/image/widgets/micro.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreBoard extends SpriteComponent with HasGameRef, CollisionCallbacks {
  bool running = false;
  double speed = 5.w;
  Sprite? spriteBreak;
  Sprite? spriteNormal;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    spriteNormal = await gameRef.loadSprite('$assetsPath/images/score-board-1.png');
    sprite = spriteNormal;
    anchor = Anchor.center;
    size = Vector2(263.w, 442.h);
    position = Vector2(1920.w + 263.w / 2, 465.h + 442.h / 2);
    priority = 1;

    spriteBreak = await gameRef.loadSprite('$assetsPath/images/score-board-2.png');

    add(RectangleHitbox());
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);
    if (running) {
      await Future.delayed(const Duration(seconds: 4, milliseconds: 250));
      if (position.x <= 1415.w + 192.w / 2) {
        position.x = 1415.w + 192.w / 2;
        running = false;

        //QuestionGame.isLoadMicro = true;
      } else {
        if(Micro.isCorrectAnswer){
          sprite = spriteNormal;
        }
        position.x -= speed;
      }
    }
  }

  @override
  Future<void> onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Arrow && Micro.isCorrectAnswer) {
      sprite = spriteBreak;
    }
  }
}
