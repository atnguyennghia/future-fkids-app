import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_vs_zombies/utils/constanst.dart';

class Logo extends StatelessWidget {
  static const ID = 'Logo';
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 289.h, left: 149.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          '$assetsPathWidget/images/logo-final.png',
          width: 722.w,
          height: 377.h,
        ),
      ),
    );
  }
}
