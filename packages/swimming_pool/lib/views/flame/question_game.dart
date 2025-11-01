import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/components/animation/fubo_swimming.dart';
import 'package:swimming_pool/components/image/flame/swimming_float_water.dart';
import 'package:swimming_pool/components/image/widgets/micro.dart';
import 'package:swimming_pool/components/parallax/parallax_background.dart';
import 'package:swimming_pool/models/coordinates.dart';
import 'package:swimming_pool/models/swimming_float.dart';
import 'package:swimming_pool/utils/constanst.dart';
import 'package:swimming_pool/utils/swimming_float_utils.dart';

class QuestionGame extends FlameGame with HasCollisionDetection {
  final Function? callBackDisplayQuestion;

  QuestionGame({required this.callBackDisplayQuestion});

  final ParallaxBackground parallaxBackground = ParallaxBackground();

  final List<int> listIndexSwimmingFloat = List.generate(7, (index) => index);
  List<int> listIndexSwimmingFloatPrevious = [];

  final List<int> listIndexPosition = [0, 1, 2];
  List<int> listIndexPositionPrevious = [];

  List<SwimmingFloatWater> listFloat = [];
  late int indexOfLane;

  late FuboSwimming fuboSwimming;
  late SwimmingFloatWater swimmingFloatWater;
  late Coordinates position;
  bool allowAddFloat = true;
  bool pause = false;

  var sprites = [
    1,
    2,
    3,
    4,
    5,
  ].map((i) => Sprite.load('$assetsPath/images/fubo-swimming-$i.png'));

  var spritesOpacity = [
    1,
    2,
    3,
    4,
    5,
  ].map((i) => Sprite.load('$assetsPath/images/fubo-swim-opacity-$i.png'));

  SpriteAnimation? spriteNormal;
  SpriteAnimation? spriteOpacity;

  SwimmingFloat getSwimmingFloat() {
    final random = Random();
    int index = random.nextInt(listIndexSwimmingFloat.length);

    if (listIndexSwimmingFloatPrevious.length == 3) {
      listIndexSwimmingFloatPrevious.clear();
    }

    //Nếu random lần đầu
    //Hoặc random các lần sau và random index không trùng với các lần random trước
    //Thì trả về object
    if (listIndexSwimmingFloatPrevious.isEmpty ||
        (listIndexSwimmingFloatPrevious.isNotEmpty &&
            !listIndexSwimmingFloatPrevious
                .contains(listIndexSwimmingFloat[index]))) {
      listIndexSwimmingFloatPrevious.add(listIndexSwimmingFloat[index]);
      return listSwimmingFloat[index];
    }
    return getSwimmingFloat();
  }

  Coordinates getPosition({int? currentIndex}) {
    final List<int> listIndexPosition = [0, 1, 2];

    final random = Random();

    if (currentIndex != null) {
      listIndexPosition.removeAt(currentIndex);
    }

    //Random index lane sau khi loại bỏ current lane
    int indexLaneRandom = random.nextInt(listIndexPosition.length);

    if (listIndexPositionPrevious.length == 2) {
      listIndexPositionPrevious.removeAt(0);
    }

    //Nếu random lần đầu
    //Hoặc random các lần sau và random index không trùng với các lần random trước
    //Thì trả về tọa độ
    if (currentIndex != null) {
      if ((listIndexPositionPrevious.isEmpty ||
              (listIndexPositionPrevious.isNotEmpty &&
                  !listIndexPositionPrevious
                      .contains(listIndexPosition[indexLaneRandom]))) &&
          indexLaneRandom != currentIndex) {
        //Lấy value tương ứng theo index lane
        //indexOfLane: là value vị trí thực tế trên màn hình, bắt đầu từ 0
        listIndexPositionPrevious.add(listIndexPosition[indexLaneRandom]);
        indexOfLane = listIndexPosition[indexLaneRandom];

        //Return tọa độ theo index lane
        return listCoordinates[indexOfLane];
      }
    } else {
      if (listIndexPositionPrevious.isEmpty ||
          (listIndexPositionPrevious.isNotEmpty &&
              !listIndexPositionPrevious
                  .contains(listIndexPosition[indexLaneRandom]))) {
        //Lấy value tương ứng theo index lane
        //indexOfLane: là value vị trí thực tế trên màn hình, bắt đầu từ 0
        listIndexPositionPrevious.add(listIndexPosition[indexLaneRandom]);
        indexOfLane = listIndexPosition[indexLaneRandom];

        //Return tọa độ theo index lane
        return listCoordinates[indexOfLane];
      }
    }

    return getPosition(currentIndex: currentIndex);
  }

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    add(parallaxBackground);

    spriteNormal = SpriteAnimation.spriteList(await Future.wait(sprites),
        stepTime: 0.1, loop: true);

    spriteOpacity = SpriteAnimation.spriteList(
        await Future.wait(spritesOpacity),
        stepTime: 0.09,
        loop: true);

    // add(IconCustom(187.w + 107.w / 2, 108.h / 2 + 40.h, 'icon-volume-on.png'));
    // add(ImageLoad(1679.w + 173.w / 2, 33.h + 114.h / 2, 173.w, 114.h,
    //     'future-kids.png', 1));

    position = getPosition();
    indexOfLane = listCoordinates.indexOf(position);
    print("indexOfLane: $indexOfLane");
    var swimmingFloat = getSwimmingFloat();

    swimmingFloatWater = SwimmingFloatWater(
        imagePath: swimmingFloat.imagePath,
        positionX: position.x,
        positionY: position.y,
        width: swimmingFloat.width,
        height: swimmingFloat.height,
        level: position.level!);

    fuboSwimming = FuboSwimming(
        positionX: 0.w, positionY: listCoordinatesFubo[indexOfLane].y);
    fuboSwimming.indexCurrentLane = indexOfLane;
    fuboSwimming.priority = position.level!;

    add(fuboSwimming);
    add(swimmingFloatWater);
  }

  @override
  Future<void> update(double dt) async {
    // TODO: implement update
    super.update(dt);
    //await Future.delayed(const Duration(seconds: 7));
    if (fuboSwimming.isCollision &&
        FuboSwimming.allowChangeLane &&
        FuboSwimming.countUpdateColiision == 1 &&
        !pause) {
      //Dừng bơi khi gặp câu hỏi
      FuboSwimming.audio.pause();

      fuboSwimming.isCollision = false;
      FuboSwimming.countUpdateColiision = 0;

      //Dừng chạy background -> set vận tốc bằng 0
      parallaxBackground.parallax?.baseVelocity = Vector2.zero();
      swimmingFloatWater.running = false;

      //Hiển thị câu hỏi
      callBackDisplayQuestion!(true);

      //Pause màn hình
      pause = true;
      fuboSwimming.playing = false;
    }

    await Future.delayed(const Duration(seconds: 8));
    if (!swimmingFloatWater.running &&
        Micro.isFinish &&
        pause &&
        Micro.isCorrectAnswer != null) {
      swimmingFloatWater.running = true;

      await Future.delayed(const Duration(seconds: 2));
      fuboSwimming.playing = true;
      parallaxBackground.parallax?.baseVelocity = Vector2(150.w, 0);

      if (Micro.isCorrectAnswer!) {
        fuboSwimming.indexCurrentLane = indexOfLane;
        position = getPosition(currentIndex: indexOfLane);
        var index = listCoordinates.indexOf(position);

        var swimmingFloat = getSwimmingFloat();
        swimmingFloatWater = SwimmingFloatWater(
            imagePath: swimmingFloat.imagePath,
            positionX: position.x,
            positionY: position.y,
            width: swimmingFloat.width,
            height: swimmingFloat.height,
            level: position.level!);

        await Future.delayed(const Duration(seconds: 2));
        fuboSwimming.indexChangeLane = listIndexPosition[index];
        fuboSwimming.positionChangeLane = listCoordinatesFubo[index].y;
        fuboSwimming.priority = position.level!;

        add(swimmingFloatWater);

        //add(swimmingFloatWater);
      } else if (!Micro.isCorrectAnswer!) {
        //Thay animation nhấp nháy khi trả lời sai
        fuboSwimming.animation = spriteOpacity;
        fuboSwimming.playing = true;

        var swimmingFloat = getSwimmingFloat();
        swimmingFloatWater = SwimmingFloatWater(
            imagePath: swimmingFloat.imagePath,
            positionX: position.x,
            positionY: position.y,
            width: swimmingFloat.width,
            height: swimmingFloat.height,
            level: position.level!);

        add(swimmingFloatWater);
      }

      //Quay lại animation ban đầu
      await Future.delayed(const Duration(seconds: 3));
      fuboSwimming.animation = spriteNormal;

      fuboSwimming.playing = true;

      //Pause màn hình khi gặp bảng điểm mới
      pause = false;
      Micro.isFinish = false;
    }
  }
}
