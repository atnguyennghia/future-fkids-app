import 'package:archery/components/image/flame/image_load.dart';
import 'package:archery/components/text/flame/text_mali.dart';
import 'package:archery/components/text/flame/title.dart';
import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalGame extends FlameGame {
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('$assetsPath/images/background-final.png')
      ..size = size;

    add(background);

    // add(ImageLoad(40.w + 1008.w / 2, 402.h + 394.h / 2, 1008.w, 394.h,
    //     '$assetsPath/images/logo-final.png', 2));

    add(ImageLoad(1083.w + 672.w / 2, 148.h + 888.h / 2, 672.w, 888.h,
        '$assetsPath/images/calculator-score.png', 0));

    add(ImageLoad(920.w + 186.w / 2, 223.h + 736.h / 2, 186.w, 736.h,
        '$assetsPath/images/star-left.png', 1));

    add(ImageLoad(1722.w + 186.w / 2, 223.h + 736.h / 2, 186.w, 736.h,
        '$assetsPath/images/star-right.png', 1));

    add(TextMali(
        1193.w + 460.w / 2,
        400.h + 78.h / 2,
        QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'RESULT BOARD'
            : 'BẢNG KẾT QUẢ'));

    add(Title(
        1193.w + 301.w / 2,
        537.h + 83.h / 2,
        QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'SCORE'
            : 'ĐIỂM SỐ'));
    //add(Content(624.w + 71.w, 526.h + 41.h, '8/10'));

    add(Title(
        1193.w + 301.w / 2,
        631.h + 83.h / 2,
        QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'TRUE'
            : 'CÂU ĐÚNG'));
    //add(Content(624.w + 71.w, 620.h + 41.h, '8/10'));

    add(Title(
        1193.w + 301.w / 2,
        725.h + 83.h / 2,
        QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'TIME'
            : 'THỜI GIAN'));
    //add(Content(624.w + 71.w, 714.h + 41.h, '30:30'));

    add(Title(
        1193.w + 301.w / 2,
        819.h + 83.h / 2,
        QuestionProvider.language == QuestionProvider.listLanguage[1]
            ? 'HIGHEST SCORE'
            : 'ĐIỂM CAO NHẤT'));
  }
}
