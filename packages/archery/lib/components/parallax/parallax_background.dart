import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParallaxBackground extends ParallaxComponent<FlameGame> {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData('$assetsPath/images/background-play.png'),
      ],
      //size: Vector2(192.w, 360.h),
      baseVelocity: Vector2(150.w, 0),
      velocityMultiplierDelta: Vector2(2, 1.0),
    );
  }
}
