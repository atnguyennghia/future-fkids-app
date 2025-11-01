import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class IconTime extends StatelessWidget {
  static const ID = 'IconTime';
  final Function? callBackShowTime;
  final bool? showTime;
  const IconTime({Key? key, this.callBackShowTime, this.showTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 334.w),
        child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            '$assetsPathWidget/images/icon-time.png',
            width: 107.w,
            height: 108.h,
          ),
        ),
      ),
      onTap: () => showTime == null
          ? null
          : (showTime! ? callBackShowTime!(false) : callBackShowTime!(true)),
    );
  }
}
