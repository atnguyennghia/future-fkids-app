
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/components/animation/zombie.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';
import 'package:plan_vs_zombies/views/flame/question_game.dart';

import '../image/widgets/micro.dart';

class Plan extends SpriteAnimationComponent with CollisionCallbacks {
  var spritesShoot = [1, 2, 3, 4, 4, 5, 5, 5, 4, 4, 3, 2, 1, 1, 1].map((i) => Sprite.load('$assetsPath/images/plan-$i.png'));
  var spritesOpacity = [1, 2, 3, 4, 5, 5, 5, 4, 3, 2, 1, 1, 1].map((i) => Sprite.load('$assetsPath/images/plan-opacity-$i.png'));
  bool ready = false;

  SpriteAnimation? spriteShoot;
  SpriteAnimation? spriteOpacity;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    spriteShoot = SpriteAnimation.spriteList(await Future.wait(spritesShoot), stepTime: 0.06, loop: false);
    spriteOpacity = SpriteAnimation.spriteList(await Future.wait(spritesOpacity), stepTime: 0.02, loop: true);

    animation = spriteShoot;
    size = Vector2(370.h, 414.h);
    position = Vector2(334.w, 432.h);
    priority = 1;
    playing = true;

    add(RectangleHitbox(size: Vector2(size.x * 0.8, size.y), position: Vector2(110.h, 0)));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if(
    //QuestionGame.dontAllowShoot &&
        Micro.isFinish && Micro.isCorrectAnswer!){
      playing = true;

      ready = true;
    } else {
      if(!isColliding){
        animation = spriteShoot;
        playing = false;
      }

    }
  }

  @override
  Future<void> onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) async {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Zombies){
      animation = spriteOpacity;
      playing = true;

      //await Future.delayed(const Duration(seconds: 2));
    }
  }
}