import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';

class StarLeft extends StatelessWidget {
  static const ID = 'StarLeft';
  const StarLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 238.h, right: 821.w),
      child: Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          '$assetsPathWidget/images/star-left.png',
          width: 186.w,
          height: 736.h,
        ),
      ),
    );
  }
}
