import 'package:flutter/cupertino.dart';
import 'package:swimming_pool/utils/constanst.dart';

class Logo extends StatelessWidget {
  static const ID = 'Logo';
  final double paddingTop, paddingLeft, width, height;

  const Logo(
      {Key? key,
      required this.paddingTop,
      required this.paddingLeft,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, left: paddingLeft),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          '$assetsPathWidget/images/logo.png',
          width: width,
          height: height,
        ),
      ),
    );
  }
}
