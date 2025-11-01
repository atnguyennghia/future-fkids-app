import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/components/animation/plan.dart';
import 'package:plan_vs_zombies/components/animation/zombie.dart';
import 'package:plan_vs_zombies/components/image/flame/plan_ball.dart';
import 'package:plan_vs_zombies/components/image/widgets/micro.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class QuestionGame extends FlameGame
    with HasCollisionDetection, HasPaint<Zombies> {
  final Function? callBackDisplayQuestion, callBackShouldShow, callBackHeart;

  QuestionGame({
    required this.callBackDisplayQuestion,
    required this.callBackShouldShow,
    required this.callBackHeart,
  });

  final List<String> listZombiesText = [
    'zombies-A',
    'zombies-B',
    'zombies-C',
  ];

  late Zombies currentZombies;
  int second = 0;
  bool allowUpdateQuestion = true, finishVoice = false;

  Timer countDown = Timer(3);
  Timer countDownIsFinish = Timer(3);

  List<int> listIndexZombiesPrevious = [];
  Plan plan = Plan();
  PlanBall planBall = PlanBall();

  //khi zombies di chuyển, dontAllowShoot = true
  //khi zombies dừng lại và hiện câu hỏi, dontAllowShoot = false
  bool dontAllowShoot = false;

  String getZombies() {
    final random = Random();
    int index = random.nextInt(listZombiesText.length);

    if (listIndexZombiesPrevious.length == 3) {
      listIndexZombiesPrevious.removeAt(0);
      listIndexZombiesPrevious.removeAt(1);
    }

    //Nếu random lần đầu
    //Hoặc random các lần sau và random index không trùng với các lần random trước
    //Thì trả về chuột
    if (listIndexZombiesPrevious.isEmpty ||
        (listIndexZombiesPrevious.isNotEmpty &&
            !listIndexZombiesPrevious.contains(index))) {
      listIndexZombiesPrevious.add(index);
      return listZombiesText[index];
    }

    return getZombies();
  }

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('$assetsPath/images/background-play.png')
      ..size = size;

    add(background);

    //add(IconBack(107.w / 2 + 40.w, 108.h / 2 + 40.h, 'icon-back.png'));
    // add(IconCustom(187.w + 107.w / 2, 108.h / 2 + 40.h, 'icon-volume-on.png'));
    // add(ImageLoad(1679.w + 173.w / 2, 33.h + 114.h / 2, 173.w, 114.h,
    //     'future-kids.png', 1));

    add(plan);

    var zombies = Zombies(
        imageAnswer: getZombies(), positionX: 1920.w + 100.w, positionY: 323.h, callBackShouldShow: callBackShouldShow, callBackHeart: callBackHeart);

    add(zombies);
    currentZombies = zombies;

    countDown = Timer(1, onTick: () => second++, repeat: true);
    countDownIsFinish = Timer(3, onTick: () => !finishVoice, repeat: true);
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);
    countDown.update(dt);

    if(!finishVoice){
      Micro.isFinish = false;
    }

    //Hiển thị câu hỏi khi zombie dừng di chuyển
    //await Future.delayed(const Duration(seconds: 2, microseconds: 750));
    if (!currentZombies.running
        && !currentZombies.playing
        && !dontAllowShoot
        && !Micro.isFinish && !finishVoice) {
      finishVoice = !finishVoice;
      callBackDisplayQuestion!(true);
    }

    //Khi zombies hiện tại đã bị bắn, thêm zombies mới
    //await Future.delayed(const Duration(seconds: 4));
    if (currentZombies.isCollision) {
      var zombies = Zombies(
          imageAnswer: getZombies(),
          positionX: 1920.w + 100.w,
          positionY: 323.h,
          callBackShouldShow: callBackShouldShow,
          callBackHeart: callBackHeart
      );

      add(zombies);
      currentZombies = zombies;
      currentZombies.running = true;

      dontAllowShoot = false;
      finishVoice = !finishVoice;
    }

    if (!currentZombies.running &&
        !dontAllowShoot &&
        Micro.isFinish &&
        Micro.isCorrectAnswer != null && finishVoice) {

      //callBackDisplayQuestion!(false);
      //Khi zombies đã dừng di chuyển và trả lời đúng => bắn
      if (Micro.isCorrectAnswer!) {
        dontAllowShoot = true;

        await Future.delayed(const Duration(milliseconds: 500));
        // if (plan.ready) {
        //   add(PlanBall());
        // }
        add(PlanBall());
      } else if (!Micro.isCorrectAnswer!) {
        //Khi zombies đã dừng di chuyển và trả lời sai => di chuyển tiếp để chạm vào cây
        currentZombies.resetAnimation = true;
        currentZombies.running = true;
      }

      if (Micro.isCorrectAnswer!) {
        //await Future.delayed(const Duration(seconds: 3));
        countDownIsFinish = Timer(3, onTick: () => !finishVoice, repeat: true);
      } else {
        //await Future.delayed(const Duration(seconds: 6));
        countDownIsFinish = Timer(currentZombies.second, onTick: () => !finishVoice, repeat: true);
      }
      countDownIsFinish.update(dt);
      //Micro.isFinish = false;
      // if(finishVoice){
      //   Micro.isFinish = false;
      // }
    }
  }
}
