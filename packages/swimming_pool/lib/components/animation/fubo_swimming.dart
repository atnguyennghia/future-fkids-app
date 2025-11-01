import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/components/image/flame/swimming_float_water.dart';
import 'package:swimming_pool/models/coordinates.dart';
import 'package:swimming_pool/utils/constanst.dart';
import 'package:swimming_pool/utils/swimming_float_utils.dart';

class FuboSwimming extends SpriteAnimationComponent with CollisionCallbacks {
  bool running = true;
  double speed = 2.w;
  double speedChangeLane = 2.h;
  double positionX, positionY;
  static int countUpdateColiision = 0;
  bool isCollision = false;

  FuboSwimming({required this.positionX, required this.positionY});

  static Bgm audio = Bgm();

  void startBgmMusic() {
    audio.initialize();
    audio.play('audio/swimming-sound.mp3', volume: 0.5);
  }

  static Future<void> stopBgmMusic() async {
    audio.stop();
    audio.dispose();
  }

  double positionChangeLane = 0;
  int? indexCurrentLane, indexChangeLane;
  static bool allowChangeLane = false;

  var sprites = [
    1,
    2,
    3,
    4,
    5,
  ].map((i) => Sprite.load('$assetsPath/images/fubo-swimming-$i.png'));

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    startBgmMusic();

    animation = SpriteAnimation.spriteList(await Future.wait(sprites),
        stepTime: 0.1, loop: true);
    size = Vector2(342.h, 316.h);
    position = Vector2(positionX, positionY);
    priority = 1;
    playing = true;
    indexCurrentLane =
        listCoordinatesFubo.indexOf(Coordinates(x: positionX, y: positionY));

    add(RectangleHitbox(
        size: Vector2(25.w, height / 4),
        position: Vector2(size.x - 80.w, size.y / 2)));
  }

  @override
  void update(double dt) async {
    // TODO: implement update
    super.update(dt);

    if (running) {
      if (position.x >= 486.w) {
        position.x = 486.w;
        running = false;
      } else {
        position.x += speed;
      }
    }

    await Future.delayed(const Duration(seconds: 1));
    //Nếu cho phép chuyển làn
    if (allowChangeLane &&
        indexCurrentLane != null &&
        indexChangeLane != null) {
      //Nếu index làn hiện tại lớn hơn index làn sẽ chuyển
      //Giảm y để chuyển làn
      if (indexCurrentLane! > indexChangeLane! &&
          position.y >= positionChangeLane) {
        position.y = positionChangeLane;

        running = false;
        allowChangeLane = false;
        indexCurrentLane = indexChangeLane;
      } else {
        position.y -= speedChangeLane;
      }

      //Nếu index làn hiện tại nhỏ hơn index làn sẽ chuyển
      //Tăng y để chuyển làn
      if (indexCurrentLane! < indexChangeLane! &&
          position.y <= positionChangeLane) {
        position.y = positionChangeLane;
        running = false;
        allowChangeLane = false;
        indexCurrentLane = indexChangeLane;
      } else {
        position.y += speedChangeLane;
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is SwimmingFloatWater) {
      isCollision = true;
      allowChangeLane = true;
      countUpdateColiision = 1;
    }
  }
}
