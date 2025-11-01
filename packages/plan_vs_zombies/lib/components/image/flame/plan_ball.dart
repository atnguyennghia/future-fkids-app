import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/components/animation/zombie.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class PlanBall extends SpriteComponent with HasGameRef, CollisionCallbacks {
  bool running = true;
  double gravity = 1.w;
  Vector2 velocity = Vector2(6.w, 0);
  bool isCollision = false;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    sprite = await gameRef.loadSprite('$assetsPath/images/plan-ball.png');
    position = Vector2(579.w, 530.h);
    size = Vector2(94.w, 94.h);
    priority = 2;

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (running) {
      velocity.x += gravity / 20;
      position += velocity;
      if (position.x >= 1920.w) {
        running = false;
        velocity = Vector2(4.w, 0);
        removeFromParent();
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Zombies) {
      //QuestionGame.ballCollision = true;
      removeFromParent();
    }
  }
}
