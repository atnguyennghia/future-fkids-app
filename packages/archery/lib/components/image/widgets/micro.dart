import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:archery/utils/msg_dialog.dart';
import 'package:archery/utils/number_to_words_english.dart';
import 'package:archery/utils/number_to_words_vietnamese.dart';
import 'package:archery/views/flame/question_game.dart';
import 'package:flame/widgets.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:get/get.dart';

class Micro extends StatefulWidget {
  final int index, countCorrect;
  final Function? callBackDisplayQuestion,
      callBackCorrectAnswer,
      callBackNextQuestion,
      callBackFinalScreen,
      callBackShouldShow,
      callBackHeart,
      callBackCaculatorScore;
  static bool isFinish = false;
  final String answerText;
  static bool isCorrectAnswer = false;

  const Micro({
    Key? key,
    required this.callBackDisplayQuestion,
    required this.callBackCorrectAnswer,
    required this.answerText,
    required this.callBackCaculatorScore,
    required this.index,
    required this.countCorrect,
    required this.callBackNextQuestion,
    required this.callBackFinalScreen,
    required this.callBackShouldShow,
    required this.callBackHeart,
  }) : super(key: key);

  @override
  State<Micro> createState() => _MicroState();
}

class _MicroState extends State<Micro> {
  bool isSpeaking = false, isCompleted = false;
  List<String> listRecognize = [];
  List<String> listAnswer = [];
  String recognizeWords = '';
  SpriteAnimation? animation;
  double totalPercent = 0.0;
  int percentComplete = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnimation();
    Micro.isFinish = false;
    listAnswer = widget.answerText.split(' ');
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getAnimation() async {
    var sprites = [1, 2, 3, 4]
        .map((i) => Sprite.load('$assetsPath/images/micro-speaking-$i.png'));
    animation = SpriteAnimation.spriteList(await Future.wait(sprites),
        stepTime: 0.18, loop: true);
  }

  void onSpeaking() async {
    try {
      stt.SpeechToText speech = stt.SpeechToText();
      bool available = await speech.initialize(
          options: [],
          onError: (err) {
            //Notify.error(err.errorMsg);
            speech.stop().then((_) {
              setState(() {
                isSpeaking = true;
              });
            });
          });

      print(available);

      if (available) {
        recognizeWords = '';
        setState(() {
          isSpeaking = true;
          isCompleted = false;
          listRecognize = [];
        });

        if (QuestionProvider.language == QuestionProvider.listLanguage[0]) {
          speech.listen(
              localeId: 'vi-VN',
              onResult: (result) {
                print(result.recognizedWords);
                setState(() {
                  recognizeWords = result.recognizedWords;

                  /// đọc chữ "số" để phân biệt giữa number và currency
                  if(recognizeWords.contains("số")){
                    recognizeWords = recognizeWords.replaceAll('số', '');
                  }
                });
              });
        } else {
          speech.listen(
              localeId: 'en-GB',
              onResult: (result) {
                print(result.recognizedWords);
                setState(() {
                  recognizeWords = result.recognizedWords;
                });
              });
        }

        await Future.delayed(const Duration(seconds: 5));
        speech.stop().then((value) {
          setState(() {
            isSpeaking = false;
            isCompleted = true;
          });

          ///thay thế ký tự dặc biệt nếu là Toán/Tiếng Việt
          if (QuestionProvider.language == QuestionProvider.listLanguage[0]) {
            recognizeWords = recognizeWords.replaceAll('/', ' phần ');
            recognizeWords = recognizeWords.replaceAll(',', ' phẩy ');
          }

          ///Chuyển đổi số thành chữ
          listRecognize = recognizeWords.split(' ');
          recognizeWords = '';
          for (var item in listRecognize) {
            if (item.isNum) {
              if (QuestionProvider.language == QuestionProvider.listLanguage[0]) {
                recognizeWords += ' ${NumberToWordsVietnamese.convert(
                    NumberFormat.decimalPattern('vi').parse(item).toInt())}';
              } else {
                recognizeWords +=
                ' ${NumberToWordsEnglish.convert(NumberFormat().parse(item).toInt())}';
              }
            } else {
              recognizeWords += ' $item';
            }
          }

          //recognizeWords = "your";
          recognizeWords = recognizeWords.trim();
          print("recognizeWords: $recognizeWords");
          listRecognize = recognizeWords.trim().split(' ');

          ///tính toán tỷ lệ chính xác

          double wordPercent = 100 / listAnswer.length;
          for (int i = 0; i < listAnswer.length; i++) {
            try {
              final listCharAnswer = listAnswer[i].split('');
              final listCharRecognize = listRecognize[i].split('');
              for (int j = 0; j < listCharAnswer.length; j++) {
                try {
                  if (listCharAnswer[j].toLowerCase() == listCharRecognize[j].toLowerCase()
                      || checkSpecialCharacter(listCharAnswer[j].toLowerCase(), listCharRecognize[j].toLowerCase())) {
                    totalPercent += wordPercent / listCharAnswer.length;
                  }
                } catch (_) {}
              }
            } catch (_) {}
          }
          percentComplete = totalPercent.round();

          checkAnswerSpeaking();
          print("widget.answerText: ${widget.answerText}");
          print("recognizeWords: ${recognizeWords}");
          print(percentComplete);

          ///Notify status
          //point = (totalPoint * percentComplete / 100).roundToDouble().toInt();
        });
      } else {
        //Notify.error("The user has denied the use of speech recognition.");
      }
      Micro.isFinish = true;
    } on PlatformException catch (e) {
      MsgDialog.showMsgDialogs(
          context: context, title: 'Notification', msg: e.message.toString());
    } on Exception catch (e) {
      MsgDialog.showMsgDialogs(
          context: context, title: 'Error', msg: e.toString());
    }
  }

  bool checkSpecialCharacter(String first, String second){
    String firstConvert = "ìíịỉĩỳýỵỷỹ";
    String secondConvert = "iiiiiyyyyy";

    for (int i = 0; i < firstConvert.length; i++) {
      first = first.replaceAll(firstConvert[i], secondConvert[i]);
      second = second.replaceAll(firstConvert[i], secondConvert[i]);
    }

    if((first == 'i' && second == 'y') || (first == 'y' && second == 'i')){
      return true;
    }
    return false;
  }

  Future<void> checkAnswerSpeaking() async {
    //listRecognize = widget.answers;
    widget.callBackDisplayQuestion!(false);
    //Nếu trả lời đúng
    if (percentComplete > 90) {
      Micro.isCorrectAnswer = true;
      //Cộng thêm điểm
      widget.callBackCaculatorScore!();

      await Future.delayed(const Duration(seconds: 2));
      FlameAudio.play('arrow-shooting.mp3', volume: 0.75);

      await Future.delayed(const Duration(milliseconds: 500));
      FlameAudio.play('tra-loi-dung.mp3', volume: 0.75);

      //Nếu chưa đến câu hỏi cuối
      if (widget.index < QuestionProvider.listQuestion.length - 1) {
        //chuyển sang câu kế tiếp
        widget.callBackNextQuestion!();
      } else {
        await Future.delayed(const Duration(seconds: 3, milliseconds: 500));
        //chuyển sang màn hình kết thúc
        widget.callBackFinalScreen!();
      }
    } else {
      Micro.isCorrectAnswer = false;
      QuestionGame.countCorrect++;

      //Nếu chọn đáp án sai, hiển thị màn hình sai
      //Gọi function để update state của class QuestionScreen
      widget.callBackCorrectAnswer!(false);
      widget.callBackShouldShow!();

      await Future.delayed(const Duration(seconds: 2));
      FlameAudio.play('arrow-shooting.mp3', volume: 0.75);

      await Future.delayed(const Duration(seconds: 1));
      FlameAudio.play('tra-loi-sai.mp3', volume: 0.75);

      await Future.delayed(const Duration(seconds: 2));
      widget.callBackHeart!();

      //Và chưa đến câu hỏi cuối, chưa hết trái tim thì chuyển sang câu hỏi kế tiếp
      if (widget.index < QuestionProvider.listQuestion.length - 1 &&
          widget.countCorrect < 4) {
        widget.callBackNextQuestion!();
      } else if (widget.index < QuestionProvider.listQuestion.length - 1 &&
          widget.countCorrect >= 4) {
        //Chưa đến câu hỏi cuối, đã hết trái tim thì chuyển sang màn hình kết thúc
        await Future.delayed(const Duration(seconds: 2));
        widget.callBackFinalScreen!();
      } else if (widget.index == QuestionProvider.listQuestion.length - 1) {
        //Đã đến câu hỏi cuối, chuyển sang màn hình kết thúc
        await Future.delayed(const Duration(seconds: 2));
        widget.callBackFinalScreen!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 1920.w,
        height: 223.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("$assetsPathWidget/images/background-micro.png"),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Text(
                    QuestionProvider.language ==
                            QuestionProvider.listLanguage[1]
                        ? 'Press the micro and say'
                        : 'Nhấn vào mic và nói',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontFamily: 'packages/archery/Dongle',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () => !isSpeaking ? onSpeaking() : null,
                  child: Image.asset(
                    isSpeaking
                        ? 'assets/icons/micro.gif'
                        : 'assets/icons/micro.png',
                    width: 130.w,
                    height: 129.h,
                  ),
                )
              ],
            ),
            isSpeaking || isCompleted
                ? Padding(
                    padding: EdgeInsets.only(left: 19.w),
                    child: Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 30.w),
                      width: ScreenUtil().setWidth(1154),
                      height: ScreenUtil().setHeight(166),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "$assetsPathWidget/images/text-speaking.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Text(
                        recognizeWords,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontFamily: 'packages/archery/Mali',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.black),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
