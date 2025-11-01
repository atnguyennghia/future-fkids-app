// ignore_for_file: constant_identifier_names;
import 'package:archery/models/question.dart';
import 'package:archery/services/question_provider.dart';
import 'package:archery/utils/constants.dart';
import 'package:archery/utils/msg_dialog.dart';
import 'package:archery/views/screen/question_screen.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class represents the button overlay.
class PlayButton extends StatelessWidget {
  static const String ID = 'PlayButton';
  String message = '';
  Function callBackPostScore;
  PlayButton({Key? key, required this.callBackPostScore}) : super(key: key);

  bool validateData() {
    message = '';
    String messageAnswerItem = 'Câu trả lời trống hoặc nội dung không hợp lệ';
    String messageQuestionName = 'Câu hỏi trống hoặc nội dung không hợp lệ ';
    String messageQuantity =
        'Lỗi: Số lượng câu hỏi không hợp lệ (tối thiểu 1 câu hoặc tối đa 10 câu)';

    if (QuestionProvider.listQuestion.isNotEmpty &&
        QuestionProvider.listQuestion.length <= 10) {
      int index = 0, countInCorrect = 0;

      for (Question item in QuestionProvider.listQuestion) {
        if (!(item.answerItem.isNotEmpty &&
            item.answerText != "" &&
            item.questionName != "")) {
          message += 'Lỗi: Dữ liệu câu hỏi thứ ${index + 1} không hợp lệ \n';
          if (item.answerItem.isEmpty || item.answerText == "") {
            message += '$messageAnswerItem\n';
          }
          if (item.questionName == "") {
            message += messageQuestionName;
          }
          countInCorrect++;
        }
        index++;
      }

      if (countInCorrect != 0) {
        return false;
      }
    } else {
      message = messageQuantity;
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1920, 1080));

    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(24),
          right: ScreenUtil().setWidth(24),
          bottom: ScreenUtil().setHeight(55)),
      child: Align(
        alignment: Alignment.bottomCenter,
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
                child: BlinkText(
                  QuestionProvider.language == QuestionProvider.listLanguage[1]
                      ? 'PLAY'
                      : 'CHƠI NGAY',
                  style: TextStyle(
                      fontSize: 58.sp,
                      fontFamily: 'packages/archery/Mali',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                  beginColor: const Color.fromRGBO(255, 255, 255, 1),
                  endColor: const Color.fromRGBO(255, 163, 45, 0),
                  softWrap: false,
                  duration: const Duration(seconds: 0, milliseconds: 400),
                ),
              ),
            ),
            onTap: () {
              var checkData = validateData();
              if (QuestionProvider.listQuestion.isEmpty && !checkData) {
                MsgDialog.showMsgDialogs(
                    context: context,
                    title: 'Thông báo',
                    msg: 'Lỗi: Không có dữ liệu câu hỏi');
              }
              //checkData = false, dữ liệu không hợp lệ
              else if (QuestionProvider.listQuestion.isNotEmpty && !checkData) {
                MsgDialog.showMsgDialogs(
                    context: context, title: 'Thông báo', msg: message);
              } else if (QuestionProvider.listQuestion.isNotEmpty &&
                  checkData) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => QuestionScreen(
                          index: 0,
                          countCorrect: 0,
                          totalPoint: 0,
                          durationSeconds: 0,
                          listQuestionAnswerRight: [],
                          callBackPostScore: callBackPostScore,
                        )));
              }
            }),
      ),
    );
  }
}
