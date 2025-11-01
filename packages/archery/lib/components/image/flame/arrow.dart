import 'dart:math' as math;

import 'package:archery/components/image/flame/score_board.dart';
import 'package:archery/components/image/widgets/micro.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Arrow extends SpriteComponent with HasGameRef, CollisionCallbacks {
  double gravity = 3;
  Vector2 velocity = Vector2(0, 0);
  bool running = true;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    sprite = await gameRef.loadSprite('$assetsPath/images/arrow.png');
    //position = Vector2(477.w, 680.h);
    size = Vector2(206.w, 17.h);
    angle = -math.pi / 60;
    priority = 3;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (running && Micro.isCorrectAnswer) {
      angle = -math.pi / 60;
      velocity.x += gravity;
      velocity.y -= gravity / 12;
      position += velocity;
      if (position.x >= 1256.w && position.y >= 553.h) {
        running = false;
        velocity = Vector2(0, 0);
      }
    } else if (running && !Micro.isCorrectAnswer) {
      if (position.x < 560.w) {
        angle = -math.pi / 60;
        velocity.x += gravity;
        velocity.y -= gravity / 8;
        position += velocity;
      }

      if (position.x > 560.w && position.x < 800.w) {
        angle = -math.pi / 30;
        velocity.x += gravity;
        velocity.y += gravity / 6;
        position += velocity;
      }

      if (position.x > 800.w && position.x < 1060.w) {
        angle = math.pi / 60;
        velocity.x += gravity;
        velocity.y += gravity / 5;
        position += velocity;
      }

      if (position.x >= 1060.w && position.x < 1360.w) {
        angle = math.pi / 20;
        velocity.x += gravity;
        velocity.y += gravity / 4;
        position += velocity;
      }

      if (position.x >= 1360.w && position.x < 1563.w) {
        angle = math.pi / 10;
        velocity.x += gravity;
        velocity.y += gravity / 1.5;
        position += velocity;
      }

      if (position.x >= 1563.w) {
        angle = math.pi / 6;
        running = false;
        velocity = Vector2(0, 0);
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is ScoreBoard) {
      //removeFromParent();
    }
  }
}
