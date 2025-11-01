import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';

import 'video_controller.dart';

class VideoView extends StatelessWidget {
  late final VideoController controller;

  VideoView({Key? key, required String videoUrl, required String tag})
      : super(key: key) {
    controller = Get.put(VideoController(videoUrl: videoUrl), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return BoxBorderGradient(
      borderRadius: BorderRadius.circular(12),
      borderSize: 3,
      child: Obx(() => controller.isLoading.value
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kAccentColor,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Chewie(
                controller: controller.chewieController!,
              ),
            )),
    );
  }
}
