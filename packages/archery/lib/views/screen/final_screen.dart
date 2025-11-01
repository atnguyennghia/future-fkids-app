import 'package:archery/components/button/try_again_button.dart';
import 'package:archery/components/image/widgets/answer_total.dart';
import 'package:archery/components/image/widgets/future_kids.dart';
import 'package:archery/components/image/widgets/heart.dart';
import 'package:archery/components/image/widgets/highest_score.dart';
import 'package:archery/components/image/widgets/icon_back.dart';
import 'package:archery/components/image/widgets/icon_time.dart';
import 'package:archery/components/image/widgets/icon_volume.dart';
import 'package:archery/components/image/widgets/logo.dart';
import 'package:archery/components/image/widgets/score_total.dart';
import 'package:archery/components/image/widgets/time_total.dart';
import 'package:archery/models/question.dart';
import 'package:archery/services/question_provider.dart';
import 'package:archery/views/flame/final_game.dart';
import 'package:archery/views/flame/start_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalScreen extends StatelessWidget {
  final int maxQuestion, countCorrect;
  final double totalPoint;
  final String? minutes, seconds;
  final List<Question> listQuestionAnswerRight;
  final Function callBackPostScore;
  final List<Heart> listHeart;

  const FinalScreen({
    Key? key,
    required this.totalPoint,
    required this.maxQuestion,
    required this.countCorrect,
    required this.minutes,
    required this.seconds,
    required this.listQuestionAnswerRight,
    required this.callBackPostScore,
    required this.listHeart,
  }) : super(key: key);

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
    // TODO: implement build
    callBackPostScore(totalPoint, false, true);
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
                FutureKids.ID,
                IconBack.ID,
                Logo.ID,
                IconVolume.ID
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
                      isStudyCompleted: true,
                    ),
                IconTime.ID: (BuildContext context, FinalGame game) =>
                    const IconTime(),
                FutureKids.ID: (BuildContext context, FinalGame game) =>
                    const FutureKids(),
                Logo.ID: (BuildContext context, FinalGame game) => const Logo(),
                IconVolume.ID: (BuildContext context, FinalGame game) =>
                    const IconVolume(),
              },
            ),
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
