import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/components/button/try_again_button.dart';
import 'package:swimming_pool/components/image/widgets/answer_total.dart';
import 'package:swimming_pool/components/image/widgets/future_kids.dart';
import 'package:swimming_pool/components/image/widgets/heart.dart';
import 'package:swimming_pool/components/image/widgets/highest_score.dart';
import 'package:swimming_pool/components/image/widgets/icon_back.dart';
import 'package:swimming_pool/components/image/widgets/icon_time.dart';
import 'package:swimming_pool/components/image/widgets/icon_volume.dart';
import 'package:swimming_pool/components/image/widgets/logo.dart';
import 'package:swimming_pool/components/image/widgets/score_total.dart';
import 'package:swimming_pool/components/image/widgets/star_left.dart';
import 'package:swimming_pool/components/image/widgets/star_right.dart';
import 'package:swimming_pool/components/image/widgets/time_total.dart';
import 'package:swimming_pool/models/question.dart';
import 'package:swimming_pool/services/question_provider.dart';
import 'package:swimming_pool/views/flame/final_game.dart';
import 'package:swimming_pool/views/flame/start_game.dart';

class FinalScreen extends StatelessWidget {
  final int maxQuestion, countCorrect;
  final double totalPoint;
  final String? minutes, seconds;
  final List<Question> listQuestionAnswerRight;
  final List<Heart> listHeart;
  final Function callBackPostScore;

  const FinalScreen(
      {Key? key,
      required this.totalPoint,
      required this.maxQuestion,
      required this.countCorrect,
      required this.minutes,
      required this.seconds,
      required this.listQuestionAnswerRight,
      required this.listHeart,
      required this.callBackPostScore})
      : super(key: key);

  Widget buildTime() {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 481.w + 25.w, top: 57.h),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '$minutes:$seconds',
          style: TextStyle(
            fontSize: 53.sp,
            fontFamily: 'packages/archery/Mali',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            shadows: const [
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    callBackPostScore(totalPoint, false, true);
    // TODO: implement build
    final FinalGame _game = FinalGame();

    return WillPopScope(
      onWillPop: () => callBackPostScore(totalPoint, true, true),
      child: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: _game,
              initialActiveOverlays: const [
                TryAgainButton.ID,
                HighestScore.ID,
                AnswerTotal.ID,
                ScoreTotal.ID,
                TimeTotal.ID,
                IconTime.ID,
                IconBack.ID,
                Logo.ID,
                StarLeft.ID,
                StarRight.ID,
                FutureKids.ID,
              ],
              overlayBuilderMap: {
                HighestScore.ID: (BuildContext context, FinalGame game) =>
                    HighestScore(
                      text:
                          "${(QuestionProvider.hightestScore)! > totalPoint ? QuestionProvider.hightestScore?.round() : totalPoint.round()}/${QuestionProvider.scoreTotal.round()}",
                    ),
                AnswerTotal.ID: (BuildContext context, FinalGame game) =>
                    AnswerTotal(
                      text: "${listQuestionAnswerRight.length}/$maxQuestion",
                    ),
                ScoreTotal.ID: (BuildContext context, FinalGame game) =>
                    ScoreTotal(
                      text:
                          "${totalPoint.round()}/${QuestionProvider.scoreTotal.round()}",
                    ),
                TimeTotal.ID: (BuildContext context, FinalGame game) =>
                    TimeTotal(
                      text: "$minutes:$seconds",
                    ),
                TryAgainButton.ID: (BuildContext context, FinalGame game) =>
                    TryAgainButton(
                      game: game,
                      answerRightLength: listQuestionAnswerRight.length,
                      callBackPostScore: callBackPostScore,
                    ),
                IconBack.ID: (BuildContext context, FinalGame game) => IconBack(
                    score: totalPoint,
                    callBackPostScore: callBackPostScore,
                    isStudyCompleted: true),
                IconTime.ID: (BuildContext context, FinalGame game) =>
                    const IconTime(),
                Logo.ID: (BuildContext context, FinalGame game) => Logo(
                      paddingLeft: 40.w,
                      paddingTop: 311.h,
                      width: 1006.w,
                      height: 421.h,
                    ),
                StarLeft.ID: (BuildContext context, FinalGame game) =>
                    const StarLeft(),
                StarRight.ID: (BuildContext context, FinalGame game) =>
                    const StarRight(),
                FutureKids.ID: (BuildContext context, FinalGame game) =>
                    const FutureKids(),
              },
            ),
            const IconVolume(),
            Padding(
              padding: EdgeInsets.only(left: 714.w, top: 47.h),
              child: Row(
                children: listHeart,
              ),
            ),
            buildTime(),
          ],
        ),
      ),
    );
  }
}
