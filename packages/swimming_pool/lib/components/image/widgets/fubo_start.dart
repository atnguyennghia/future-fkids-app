import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class FuboStart extends StatelessWidget {
  static const ID = 'FuboStart';
  const FuboStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 382.h, left: 135.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          '$assetsPathWidget/images/fubo-start.png',
          width: 421.w,
          height: 635.h,
        ),
      ),
    );
  }
}
