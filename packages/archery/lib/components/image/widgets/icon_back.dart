import 'package:archery/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBack extends StatelessWidget {
  static const ID = 'IconBack';
  final double score;
  final Function callBackPostScore;
  final bool isStudyCompleted;
  const IconBack(
      {Key? key, required this.score, required this.callBackPostScore, required this.isStudyCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 40.w),
        child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            '$assetsPathWidget/images/icon-back.png',
            width: 107.w,
            height: 108.h,
          ),
        ),
      ),
      onTap: () => callBackPostScore(score, true, isStudyCompleted),
    );
  }
}
