import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/components/animation/fubo_swimming.dart';
import 'package:swimming_pool/components/image/flame/image_load.dart';
import 'package:swimming_pool/components/text/flame/text_mali.dart';
import 'package:swimming_pool/components/text/flame/title.dart';
import 'package:swimming_pool/services/question_provider.dart';
import 'package:swimming_pool/utils/constanst.dart';

class FinalGame extends FlameGame {
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    super.onLoad();
    FuboSwimming.audio.stop();

    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('$assetsPath/images/background-start.png')
      ..size = size;

    add(background);

    //add(IconBack(107.w / 2 + 40.w, 108.h / 2 + 40.h, 'icon-back.png'));
    // add(IconCustom(187.w + 107.w / 2, 108.h / 2 + 40.h, 'icon-volume-on.png'));
    // add(ImageLoad(1679.w + 173.w / 2, 33.h + 114.h / 2, 173.w, 114.h,
    //     'future-kids.png', 1));
    //
    // add(ImageLoad(40.w + 1006.w / 2, 311.h + 421.h / 2, 1006.w, 421.h,
    //     'logo.png', 2));

    add(ImageLoad(1083.w + 672.w / 2, 148.h + 888.h / 2, 672.w, 888.h,
        '$assetsPath/images/calculator-score.png', 0));

    // add(ImageLoad(920.w + 186.w / 2, 223.h + 736.h / 2, 186.w, 736.h,
    //     '$assetsPath/images/star-left.png', 1));

    // add(ImageLoad(1722.w + 186.w / 2, 223.h + 736.h / 2, 186.w, 736.h,
    //     '$assetsPath/images/star-right.png', 1));

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
