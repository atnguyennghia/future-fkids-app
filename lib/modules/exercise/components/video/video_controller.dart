import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final String videoUrl;
  VideoController({required this.videoUrl});

  // PodPlayerController? podPlayerController;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  final isLoading = true.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    videoPlayerController = VideoPlayerController.network(videoUrl);
    await videoPlayerController?.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: false,
      looping: false,
      aspectRatio: videoPlayerController?.value.aspectRatio,
      autoInitialize: true,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]
    );

    // podPlayerController = PodPlayerController(
    //   playVideoFrom: PlayVideoFrom.network(videoUrl),
    //   podPlayerConfig: const PodPlayerConfig(
    //     autoPlay: false,
    //   ),
    // );
    // await podPlayerController?.initialise();

    isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();

    // podPlayerController?.dispose();

    super.onClose();
  }
}
