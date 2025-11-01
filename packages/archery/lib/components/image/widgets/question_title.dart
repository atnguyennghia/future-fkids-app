import 'package:archery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      margin: EdgeInsets.only(top: 182.h, left: 543.w),
      alignment: Alignment.center,
      width: 835.w,
      height: 438.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('$assetsPathWidget/images/question-image.png'),
            fit: BoxFit.fill),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Text(
          questionText,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 37.sp,
              fontFamily: 'packages/archery/Mali',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.white),
        ),
      ),
    );
  }
}
