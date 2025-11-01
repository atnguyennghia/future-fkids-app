import 'package:archery/components/animation/fubo_archery.dart';
import 'package:archery/components/image/flame/arrow.dart';
import 'package:archery/components/image/flame/image_load.dart';
import 'package:archery/components/image/flame/score_board.dart';
import 'package:archery/components/image/widgets/micro.dart';
import 'package:archery/components/parallax/parallax_background.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionGame extends FlameGame with HasCollisionDetection {
  final Function? callBackDisplayQuestion;

  QuestionGame({required this.callBackDisplayQuestion});

  final ParallaxBackground parallaxBackground = ParallaxBackground();
  ScoreBoard scoreBoard = ScoreBoard();
  Arrow arrow = Arrow();
  final FuboArchery fuboArchery = FuboArchery();
  bool pause = false;
  static int countCorrect = 0;

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    super.onLoad();
    add(parallaxBackground);

    add(fuboArchery);
    fuboArchery.playing = true;

    add(scoreBoard);
    scoreBoard.running = true;

    add(arrow);
    //arrow.running = false;
    arrow.position = Vector2(1820.w + 206.w / 2, 495.h + 17.h / 2);
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);

    if (!scoreBoard.running && !pause) {
      //Dừng chạy background -> set vận tốc bằng 0
      parallaxBackground.parallax?.baseVelocity = Vector2.zero();

      if(countCorrect < 5){
        //Hiển thị câu hỏi
        callBackDisplayQuestion!(true);
      }

      //Pause màn hình
      pause = true;
    }

    if (!scoreBoard.running && Micro.isFinish && pause) {
      //Thêm mũi tên
      arrow.running = true;
      arrow.position = Vector2(477.w, 720.h);
      arrow.velocity = Vector2(0, 0);
      //add(arrow);

      //Xóa bảng mục tiêu sau khi bắn mũi tên
      Future.delayed(const Duration(seconds: 3), () {
        scoreBoard.position = Vector2(1920.w + 192.w / 2, 495.h + 360.h / 2);

        arrow.position = Vector2(1820.w + 206.w / 2, 495.h + 17.h / 2);
        arrow.velocity = Vector2(0, 0);
        arrow.running = false;
      });
      //remove(scoreBoard);

      await Future.delayed(const Duration(seconds: 2));

      //Set vận tốc
      if (!Micro.isCorrectAnswer) {
        Future.delayed(const Duration(seconds: 2, milliseconds: 700), () {
          parallaxBackground.parallax?.baseVelocity = Vector2(150.w, 0);
        });
      } else {
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          parallaxBackground.parallax?.baseVelocity = Vector2(150.w, 0);
        });
      }

      //Tiếp tục animation của nhân vật chạy
      fuboArchery.playing = true;

      //Thêm bảng điểm
      scoreBoard.running = true;
      //add(scoreBoard);

      //Pause màn hình khi gặp bảng điểm mới
      pause = false;
      Micro.isFinish = false;
    }

    if (!scoreBoard.running && !Micro.isFinish && pause) {
      //Dừng animation của nhân vật khi hiện câu hỏi
      fuboArchery.playing = false;
    }
  }
}
