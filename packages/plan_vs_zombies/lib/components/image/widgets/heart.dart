import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Heart extends StatelessWidget {
  static const String ID = 'Heart';
  final String imagePath;
  const Heart({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          imagePath,
          width: 99.w,
          height: 86.h,
        ),
      ),
    );
  }
}
