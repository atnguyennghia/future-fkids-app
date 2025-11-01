import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/components/animation/plan.dart';
import 'package:plan_vs_zombies/components/image/flame/plan_ball.dart';
import 'package:plan_vs_zombies/components/image/widgets/micro.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class Zombies extends SpriteAnimationComponent with CollisionCallbacks {
  final double positionX, positionY;
  final String imageAnswer;
  final List<int> listFrame = [1, 2, 3, 4, 4, 4, 4, 3, 2, 1, 1];
  bool running = true;
  double speed = 2.w;
  bool isCollision = false;
  bool resetAnimation = true;
  double second = 0;
  int start = 0, end = 0;
  Timer countUp = Timer(1);
  final Function? callBackShouldShow, callBackHeart;

  Zombies({required this.callBackShouldShow,
    required this.callBackHeart,
        required this.imageAnswer,
      required this.positionX,
      required this.positionY});

  SpriteAnimation? spriteAnimation;
  SpriteAnimation? spriteAnimationOpacity;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    var sprites = listFrame
        .map((i) => Sprite.load('$assetsPath/images/$imageAnswer-$i.png'));
    final spritesOpacity = listFrame.map(
        (i) => Sprite.load('$assetsPath/images/$imageAnswer-opacity-$i.png'));

    spriteAnimation = SpriteAnimation.spriteList(await Future.wait(sprites),
        stepTime: 0.12, loop: true);
    spriteAnimationOpacity = SpriteAnimation.spriteList(
        await Future.wait(spritesOpacity),
        stepTime: 0.08,
        loop: true);

    animation = spriteAnimation;
    size = Vector2(289.h, 488.h);
    position = Vector2(positionX, positionY);
    priority = 2;
    countUp = Timer(1, onTick: () => second++, repeat: true);

    add(RectangleHitbox(
        size: Vector2(20.w, 390.h), position: Vector2(160.h, 80.h)));
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);
    countUp.update(dt);

    ///Zoombie chạy khi không hiển thị micro
    if (running && !Micro.isFinish) {
      //await Future.delayed(const Duration(seconds: 4));
      if (position.x <= 1085.w) {
        position.x = 1085.w;
        running = false;
        playing = false;
      } else {
        position.x -= speed;
      }
    } ///Trường hợp zoombie chạy khi micro kết thúc và trả lời sai
    else if (running && Micro.isFinish && !Micro.isCorrectAnswer!) {
      start++;

      if (resetAnimation) {
        playing = true;

        resetAnimation = false;
      }
      if (position.x <= 520.w) {
        position.x = 520.w;
        end++;
        if(end == 1){
          countUp.stop();
          Micro.secondDelay = second;
        }
      } else {
        if(start == 1){
          second = 0;
          countUp.start();
        }
        position.x -= speed;
      }
    } ///Trường hợp zoombie chạy khi micro kết thúc và trả lời đúng
    // else if (running && Micro.isFinish && Micro.isCorrectAnswer!) {
    //   middle++;
    //   //running = false;
    //   if(middle == 1){
    //     countUp.stop();
    //     Micro.secondDelay = second * (2 / 3);
    //   }
    // }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlanBall) {
      animation = spriteAnimationOpacity;
      playing = true;

      await Future.delayed(const Duration(seconds: 2));
      removeFromParent();
      isCollision = true;
    }

    if (other is Plan) {
      animation = spriteAnimationOpacity;
      playing = true;
      running = false;

      FlameAudio.play('sound-bite-zombies.mp3', volume: 0.75);

      await Future.delayed(const Duration(milliseconds: 500));
      callBackHeart!();
      await Future.delayed(const Duration(milliseconds: 500));
      callBackShouldShow!();
      FlameAudio.play('tra-loi-sai.mp3', volume: 0.75);

      await Future.delayed(const Duration(seconds: 1));
      removeFromParent();
      isCollision = true;
    }
  }
}
