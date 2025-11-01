import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class SwimmingFloatWater extends SpriteComponent
    with HasGameRef, CollisionCallbacks {
  double positionX, positionY, width, height;
  String imagePath;
  double speed = 2.w;
  int level;
  bool running = true;

  SwimmingFloatWater(
      {required this.imagePath,
      required this.positionX,
      required this.positionY,
      required this.width,
      required this.height,
      required this.level});

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    sprite = await gameRef.loadSprite("$assetsPath/images/$imagePath");
    position = Vector2(positionX, positionY);
    size = Vector2(width, height);
    priority = level;

    add(RectangleHitbox(
        size: Vector2(10.w, height / 3), position: Vector2(0.w, size.y / 2)));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (running) {
      position.x -= speed;
      if (position.x < -350.w) {
        removeFromParent();
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
  }
}
