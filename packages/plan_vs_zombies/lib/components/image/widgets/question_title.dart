import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class QuestionTitle extends StatelessWidget {
  static const ID = "QuestionTitle";
  final String questionText;
  const QuestionTitle({
    Key? key,
    required this.questionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage('$assetsPathWidget/images/background-question.png'),
            fit: BoxFit.cover),
      ),
      child: Container(
        //margin: EdgeInsets.only(top: 143.h),
        alignment: Alignment.topCenter,
        width: 976.w,
        height: 670.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('$assetsPathWidget/images/question-image.png'),
              fit: BoxFit.fill),
        ),
        child: Container(
          width: 976.w,
          height: 535.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 107.w),
          child: Text(
            questionText,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 37.sp,
                fontFamily: 'packages/plan_vs_zombies/Mali',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
