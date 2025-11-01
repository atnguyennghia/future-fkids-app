import 'package:archery/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoFirst extends StatelessWidget {
  static const ID = 'LogoFirst';
  const LogoFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 296.h, right: 94.w),
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          '$assetsPathWidget/images/logo.png',
          width: 1787.w,
          height: 611.h,
        ),
      ),
    );
  }
}
