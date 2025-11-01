import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class StarRight extends StatelessWidget {
  static const ID = 'StarRight';
  const StarRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 238.h, right: 19.w),
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          '$assetsPathWidget/images/star-right.png',
          width: 186.w,
          height: 736.h,
        ),
      ),
    );
  }
}
