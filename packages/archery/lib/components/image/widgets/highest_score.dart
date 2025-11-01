import 'package:archery/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HighestScore extends StatelessWidget {
  static const ID = "HighestScore";
  final text;
  const HighestScore({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 1514.w, top: 819.h),
      child: Container(
        alignment: Alignment.topLeft,
        width: 143.w,
        height: 83.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("$assetsPathWidget/images/yellow-content.png"),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.sp,
                fontFamily: 'packages/archery/Mali',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
