import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'audio_controller.dart';

class AudioView extends StatelessWidget {
  final String fromURI;
  final double? width;
  final double? height;
  late final AudioController controller;

  AudioView(
      {Key? key,
      required this.fromURI,
      required String tag,
      this.width = 40,
      this.height = 40})
      : super(key: key) {
    controller = Get.put(AudioController(), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.isPlaying.value ? null : controller.play(fromURI),
      child: Obx(() => controller.isPlaying.value
          ? Image.asset(
              'assets/icons/loa.gif',
              width: width,
              height: height,
            )
          : Image.asset(
              'assets/icons/loa.png',
              width: width,
              height: height,
            )),
    );
  }
}
