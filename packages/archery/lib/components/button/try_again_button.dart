// ignore_for_file: constant_identifier_names
import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:archery/views/flame/question_game.dart';
import 'package:archery/views/screen/question_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class represents the pause button overlay.
class TryAgainButton extends StatelessWidget {
  static const String ID = 'TryAgainButton';
  final FlameGame game;
  final int answerRightLength;
  final Function callBackPostScore;

  const TryAgainButton(
      {Key? key,
      required this.game,
      required this.answerRightLength,
      required this.callBackPostScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 301.w,
        top: 744.h,
      ),
      child: InkWell(
          child: Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(391),
            height: ScreenUtil().setHeight(160),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("$assetsPathWidget/images/button.png"),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                answerRightLength == QuestionProvider.listQuestion.length &&
                        QuestionProvider.language ==
                            QuestionProvider.listLanguage[1]
                    ? "REPLAY"
                    : (answerRightLength ==
                                QuestionProvider.listQuestion.length &&
                            QuestionProvider.language ==
                                QuestionProvider.listLanguage[0]
                        ? 'CHƠI LẠI'
                        : (answerRightLength !=
                                    QuestionProvider.listQuestion.length &&
                                QuestionProvider.language ==
                                    QuestionProvider.listLanguage[1])
                            ? 'TRY AGAIN'
                            : 'THỬ LẠI'),
                style: TextStyle(
                    fontSize: 58.sp,
                    fontFamily: 'packages/archery/Mali',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: Colors.white),
              ),
            ),
          ),
          onTap: () {
            QuestionGame.countCorrect = 0;
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => QuestionScreen(
                      index: 0,
                      countCorrect: 0,
                      totalPoint: 0,
                      durationSeconds: 0,
                      listQuestionAnswerRight: [],
                      callBackPostScore: callBackPostScore,
                    )));
          }),
    );
  }
}
