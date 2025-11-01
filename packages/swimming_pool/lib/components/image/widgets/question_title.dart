import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

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
      margin: EdgeInsets.only(top: 157.h, left: 371.w),
      alignment: Alignment.center,
      width: 1227.w,
      height: 256.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('$assetsPathWidget/images/question-image.png'),
            fit: BoxFit.fill),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Text(
          questionText,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 36.sp,
              fontFamily: 'packages/swimming_pool/Mali',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: Colors.black),
        ),
      ),
    );
  }
}
