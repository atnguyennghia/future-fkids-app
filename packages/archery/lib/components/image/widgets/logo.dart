import 'package:archery/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  static const ID = 'Logo';
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 402.h, left: 40.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          '$assetsPathWidget/images/logo-final.png',
          width: 1008.w,
          height: 394.h,
        ),
      ),
    );
  }
}
