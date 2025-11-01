import 'dart:math';

import 'package:futurekids/utils/custom_theme.dart';
import 'package:get/get.dart';

import 'audio_playback_controller.dart';
import 'package:flutter/material.dart';

class AudioPlaybackView extends StatelessWidget {
  late final AudioPlaybackController controller;
  final String url;

  AudioPlaybackView({Key? key, required this.url, required String tag})
      : super(key: key) {
    controller = Get.put(AudioPlaybackController(url: url), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    '${controller.position.value.inMinutes.remainder(60).toString().padLeft(2, '0')}:${controller.position.value.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: CustomTheme.medium(14),
                  )),
              Obx(() => controller.isPlaying.value
                  ? InkWell(
                      onTap: () => controller.getPlaybackFn(),
                      child: const Icon(
                        Icons.pause_circle,
                        size: 24,
                      ),
                    )
                  : InkWell(
                      onTap: () => controller.getPlaybackFn(),
                      child: const Icon(
                        Icons.play_circle,
                        size: 24,
                      ),
                    )),
              Obx(() => Text(
                    '${controller.duration.value.inMinutes.remainder(60).toString().padLeft(2, '0')}:${controller.duration.value.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: CustomTheme.medium(14),
                  )),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            thumbColor: Colors.black,
            activeTrackColor: Colors.black,
            inactiveTrackColor: const Color(0xffd9d9d9),
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 4,
            ),
            trackShape: CustomTrackShape(),
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Obx(() => Slider(
                value: controller.position.value.inSeconds.toDouble(),
                max: max(controller.duration.value.inSeconds.toDouble(), 1),
                onChanged: (value) {
                  controller.position.value = Duration(seconds: value.toInt());
                  controller.seek();
                },
                divisions: max(controller.duration.value.inSeconds.toInt(), 1),
              )),
        )
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    TextPainter? labelPainter,
    Offset? secondaryOffset,
    bool isPressed = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(context, offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        isDiscrete: isDiscrete,
        isEnabled: isEnabled);
  }
}
