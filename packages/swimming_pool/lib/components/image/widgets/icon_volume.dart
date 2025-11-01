import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swimming_pool/utils/constanst.dart';
import 'package:swimming_pool/views/flame/start_game.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconVolume extends StatefulWidget {
  static const ID = 'IconVolume';
  const IconVolume({Key? key}) : super(key: key);
  static int volumeClick = 0;

  @override
  State<IconVolume> createState() => _IconVolumeState();
}

class _IconVolumeState extends State<IconVolume> {
  late String imageButtonPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //IconVolume.volumeClick = IconCustom.onClick;
    if (IconVolume.volumeClick % 2 == 1) {
      setState(() {
        imageButtonPath = 'icon-volume-off.png';
      });
    } else if (IconVolume.volumeClick % 2 == 0) {
      setState(() {
        imageButtonPath = 'icon-volume-on.png';
      });
    }
  }

  void onClickVolume() {
    IconVolume.volumeClick++;
    if (IconVolume.volumeClick % 2 == 1) {
      StartGameSwimmingPool.audio.pause();
      setState(() {
        imageButtonPath = 'icon-volume-off.png';
      });
    } else if (IconVolume.volumeClick % 2 == 0) {
      StartGameSwimmingPool.audio.resume();
      setState(() {
        imageButtonPath = 'icon-volume-on.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => onClickVolume(),
      child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 187.w),
        child: Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            '$assetsPathWidget/images/$imageButtonPath',
            width: 107.w,
            height: 108.h,
          ),
        ),
      ),
    );
  }
}
