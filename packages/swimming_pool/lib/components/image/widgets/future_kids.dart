import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class FutureKids extends StatelessWidget {
  static const ID = 'FutureKids';
  const FutureKids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 33.h, right: 68.w),
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          '$assetsPathWidget/images/future-kids.png',
          width: 173.w,
          height: 116.h,
        ),
      ),
    );
  }
}
