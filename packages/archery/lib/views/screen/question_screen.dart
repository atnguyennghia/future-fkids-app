import 'dart:async';

import 'package:archery/components/image/widgets/future_kids.dart';
import 'package:archery/components/image/widgets/heart.dart';
import 'package:archery/components/image/widgets/icon_back.dart';
import 'package:archery/components/image/widgets/icon_time.dart';
import 'package:archery/components/image/widgets/icon_volume.dart';
import 'package:archery/components/image/widgets/micro.dart';
import 'package:archery/components/image/widgets/question_title.dart';
import 'package:archery/components/text/widgets/text_timer.dart';
import 'package:archery/models/question.dart';
import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:archery/views/flame/question_game.dart';
import 'package:archery/views/flame/start_game.dart';
import 'package:archery/views/screen/final_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionScreen extends StatefulWidget {
  int index;
  double totalPoint;
  int countCorrect;
  int durationSeconds;
  List<Question> listQuestionAnswerRight;
  Function callBackPostScore;

  QuestionScreen(
      {Key? key,
      required this.index,
      required this.countCorrect,
      required this.totalPoint,
      required this.durationSeconds,
      required this.listQuestionAnswerRight,
      required this.callBackPostScore})
      : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

class _QuestionScreen extends State<QuestionScreen> {
  late Question question;
  bool isDisplayQuestion = false;
  late final QuestionGame game;
  bool? correctAnswer, shouldShow, showTime, stopTime;
  late int durationSeconds;
  late double totalPoint;
  late TextTimer textTimer;
  List<Question> listQuestionAnswerRight = [];
  double paddingHeart = 714.w;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = QuestionProvider.listQuestion[widget.index];
    showTime = true;
    durationSeconds = widget.durationSeconds;
    listQuestionAnswerRight = widget.listQuestionAnswerRight;
    totalPoint = widget.totalPoint;
    textTimer = TextTimer(
        index: widget.index,
        durationSeconds: durationSeconds,
        callBackDuration: callBackDuration,
        showTime: showTime);
    game = QuestionGame(callBackDisplayQuestion: callBackDisplayQuestion);
  }

  List<Heart> getHeart() {
    List<Heart> list = List.generate(
        5,
        (index) =>
            const Heart(imagePath: '$assetsPathWidget/images/heart-red.png'));

    //Trừ số lượng trái tim nếu trả lời sai ở các câu trước
    if (widget.countCorrect > 0) {
      for (var i = 0; i < widget.countCorrect; i++) {
        list.removeAt(list.length - 1 - i);
        list.add(const Heart(
            imagePath: '$assetsPathWidget/images/heart-border.png'));
      }
    }
    return list;
  }

  late List<Heart> listHeart = getHeart();

  //Trừ trái tim khi trả lời sai câu hỏi và chuyển sang câu hỏi kế tiếp
  void callBackHeart() {
    if (correctAnswer == false) {
      if (widget.countCorrect < 5) {
        widget.countCorrect++;
        if (widget.countCorrect > 0) {
          for (var i = 0; i < widget.countCorrect; i++) {
            setState(() {
              listHeart.removeAt(listHeart.length - 1 - i);
              listHeart.add(const Heart(
                  imagePath: '$assetsPathWidget/images/heart-border.png'));
            });
          }
        }
      }
      // widget.index++;
    }
  }

  void callBackCaculatorScore() {
    Question question = QuestionProvider.listQuestion[widget.index];
    listQuestionAnswerRight.add(question);

    setState(() {
      totalPoint += question.point;
    });
  }

  //Kiểm tra trả lời sai hay đúng
  void callBackCorrectAnswer(bool? newValue) {
    setState(() {
      correctAnswer = newValue;
    });
  }

  //Hiển thị màn hình trả lời sai
  Future<void> callBackShouldShow() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      shouldShow = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      shouldShow = false;
    });
  }

  void callBackStopTimer([bool resets = true]) {
    textTimer.callBackStopTimer!(resets);
  }

  void callBackDuration(int duration) {
    durationSeconds = duration;
  }

  void callBackDisplayTime(bool value) {
    textTimer.callBackDisplayTime!(value);
    setState(() {
      showTime = value;
      if (showTime!) {
        paddingHeart = 714.w;
      } else if (!showTime!) {
        paddingHeart = 481.w;
      }
    });
  }

  void callBackNextQuestion() {
    setState(() {
      widget.index++;
      question = QuestionProvider.listQuestion[widget.index];
    });
  }

  Future<void> callBackFinalScreen() async {
    callBackStopTimer();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FinalScreen(
              maxQuestion: QuestionProvider.listQuestion.length,
              totalPoint: totalPoint,
              countCorrect: widget.countCorrect,
              minutes: textTimer.minutes,
              seconds: textTimer.seconds,
              listHeart: listHeart,
              listQuestionAnswerRight: listQuestionAnswerRight,
              callBackPostScore: widget.callBackPostScore,
            )));
  }

  Widget backgroundInCorrect(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("$assetsPathWidget/images/background-incorrect.png"),
        fit: BoxFit.cover,
      ),
    ));
  }

  Widget backgroundInCorrectEng(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
      image: DecorationImage(
        image:
            AssetImage("$assetsPathWidget/images/background-incorrect-eng.png"),
        fit: BoxFit.cover,
      ),
    ));
  }

  void callBackDisplayQuestion(bool value) {
    setState(() {
      isDisplayQuestion = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.init(context, designSize: const Size(1920, 1080));
    return WillPopScope(
      onWillPop: () => widget.callBackPostScore(totalPoint, true, false),
      child: Scaffold(
        body: Stack(
          children: [
            GameWidget(game: game, initialActiveOverlays: const [
              IconBack.ID,
              FutureKids.ID,
              IconVolume.ID
            ], overlayBuilderMap: {
              IconBack.ID: (BuildContext context, QuestionGame game) =>
                  IconBack(
                    score: totalPoint,
                    callBackPostScore: widget.callBackPostScore,
                    isStudyCompleted: false,
                  ),
              FutureKids.ID: (BuildContext context, QuestionGame game) =>
                  const FutureKids(),
              IconVolume.ID: (BuildContext context, QuestionGame game) =>
                  const IconVolume(),
            }),
            isDisplayQuestion
                ? QuestionTitle(questionText: question.questionName)
                : Container(),
            isDisplayQuestion
                ? Micro(
                    callBackDisplayQuestion: callBackDisplayQuestion,
                    callBackCorrectAnswer: callBackCorrectAnswer,
                    answerText: question.answerText,
                    index: widget.index,
                    countCorrect: widget.countCorrect,
                    callBackNextQuestion: callBackNextQuestion,
                    callBackFinalScreen: callBackFinalScreen,
                    callBackShouldShow: callBackShouldShow,
                    callBackHeart: callBackHeart,
                    callBackCaculatorScore: callBackCaculatorScore,
                  )
                : Container(),
            IconTime(
              callBackShowTime: callBackDisplayTime,
              showTime: showTime,
            ),
            Padding(
              padding: EdgeInsets.only(left: paddingHeart, top: 47.h),
              child: Row(
                children: listHeart,
              ),
            ),
            textTimer,
            (correctAnswer == false &&
                    shouldShow == true &&
                    QuestionProvider.language ==
                        QuestionProvider.listLanguage[0])
                ? backgroundInCorrect(context)
                : (
                    //Hiển thị sai khi tiếng Anh
                    (correctAnswer == false &&
                            shouldShow == true &&
                            QuestionProvider.language ==
                                QuestionProvider.listLanguage[1])
                        ? backgroundInCorrectEng(context)
                        : Container()),
          ],
        ),
      ),
    );
  }
}
