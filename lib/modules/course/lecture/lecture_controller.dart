import 'dart:convert';
// import 'package:chewie/chewie.dart';
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/data/providers/submit_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/modules/lesson/lesson_controller.dart';
import 'package:futurekids/modules/unit/unit_controller.dart';
import 'package:futurekids/services/auth_service.dart';
// import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/notify.dart';
// import 'package:futurekids/widgets/stroke_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
import 'package:subtitle/subtitle.dart' as sub;

class LectureController extends GetxController {
  final courseController = Get.find<CourseController>();

  CategoryModel category;
  dynamic contentId;
  dynamic point;
  bool notSubmitted = true;

  final selectedSubtitle = 0.obs;

  bool isSubmitting = false;

  LectureController({required this.category});

  // VideoPlayerController? videoPlayerController;
  // ChewieController? chewieController;

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  sub.SubtitleController? subControllerVI;
  sub.SubtitleController? subControllerEN;

  final isLoading = true.obs;
  final listDuration = <Map<String, dynamic>>[].obs;

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  void submitData() async {
    isSubmitting = true;
    final provider = SubmitProvider();
    final result = await provider
        .submitData(
            profileId: AuthService.to.profileModel.value.id,
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            contentId: contentId,
            point: point,
            percentComplete: 100)
        .catchError((err) {
      Notify.error(err);
      isSubmitting = false;
    });
    if (result != null && result) {
      notSubmitted = false;
      //fetch lại data lesson, unit
      Get.find<LessonController>().fetchLesson();
      Get.find<UnitController>().fetchUnit();
      isSubmitting = false;
    }
  }

  void checkVideo() {
    // if (courseController.listCategory[courseController.selectedCategory.value]
    //         .contentType !=
    //     "1") {
    //   if (videoPlayerController!.value.isPlaying) {
    //     videoPlayerController?.pause();
    //   }
    // }

    if (chewieController!.isFullScreen &&
        videoPlayerController!.value.position.inSeconds ==
            videoPlayerController!.value.duration.inSeconds) {
      chewieController?.exitFullScreen();
    }

    if (courseController.listCategory[courseController.selectedCategory.value]
            .contentType !=
        "1") {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController?.pause();
      }
    }

    // for (int i = 0; i < listDuration.length; i++) {
    //   if (parseDuration(listDuration[i]["time"])
    //           .compareTo(videoPlayerController!.value.position) >
    //       0) {
    //     listDuration[i]["status"] = 0;
    //     listDuration.refresh();
    //   } else {
    //     listDuration[i]["status"] = 1;
    //     listDuration.refresh();
    //   }
    // }

    for (int i = 0; i < listDuration.length; i++) {
      if (parseDuration(listDuration[i]["time"])
              .compareTo(videoPlayerController!.value.position) >
          0) {
        listDuration[i]["status"] = 0;
        listDuration.refresh();
      } else {
        listDuration[i]["status"] = 1;
        listDuration.refresh();
      }
    }

    ///Kiểm tra nếu >= 80% bài học thì gửi kết quả
    // if (AuthService.to.hasLogin) {
    //   if (!isSubmitting &&
    //       notSubmitted &&
    //       videoPlayerController!.value.position.inSeconds /
    //               videoPlayerController!.value.duration.inSeconds >=
    //           0.8) {
    //     submitData();
    //   }
    // }

    if (AuthService.to.hasLogin) {
      if (!isSubmitting &&
          notSubmitted &&
          videoPlayerController!.value.position.inSeconds /
                  videoPlayerController!.value.duration.inSeconds >=
              0.8) {
        submitData();
      }
    }
  }

  Future<String?> fetchContent() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getContent(
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            categoryType: 1)
        .catchError((err) {
      Notify.error(err);
    });

    if (result != null) {
      contentId = result["contents"][0]["id"];
      point = result["contents"][0]["point"];

      ///load timeline
      final listTimeline =
          json.decode(result["contents"][0]["timeline"]) as List<dynamic>;
      for (var e in listTimeline) {
        listDuration.add({
          "time": "${e["time"]}",
          "content": "${e["content"]}",
          "status": 0
        });
      }
      listDuration.refresh();

      ///load subtitle
      if (result['contents'][0]['text_tracks'] != null) {
        for (var item in result['contents'][0]['text_tracks']) {
          if (item['lang'] == 'vi') {
            subControllerVI = sub.SubtitleController(
                provider: sub.SubtitleProvider.fromString(
              data: item['text'],
              type: sub.SubtitleType.srt,
            ));
          }
          if (item['lang'] == 'en') {
            subControllerEN = sub.SubtitleController(
                provider: sub.SubtitleProvider.fromString(
              data: item['text'],
              type: sub.SubtitleType.srt,
            ));
          }
        }
      }
      debugPrint('video==>>>: ${result["contents"][0]["video"]}');
      return result["contents"][0]["video"];
    }
    return null;
  }

  // Future<Subtitles?> getSubtitle({required String? lang}) async {
  //   if (lang == null) {
  //     return Subtitles([]);
  //   }
  //   if (lang == 'vi') {
  //     await subControllerVI?.initial();
  //     return Subtitles([
  //       ...List.generate(subControllerVI!.subtitles.length, (index) {
  //         return Subtitle(
  //             index: subControllerVI!.subtitles[index].index,
  //             start: subControllerVI!.subtitles[index].start,
  //             end: subControllerVI!.subtitles[index].end,
  //             text: subControllerVI!.subtitles[index].data);
  //       })
  //     ]);
  //   } else {
  //     await subControllerEN?.initial();
  //     return Subtitles([
  //       ...List.generate(subControllerEN!.subtitles.length, (index) {
  //         return Subtitle(
  //             index: subControllerEN!.subtitles[index].index,
  //             start: subControllerEN!.subtitles[index].start,
  //             end: subControllerEN!.subtitles[index].end,
  //             text: subControllerEN!.subtitles[index].data);
  //       })
  //     ]);
  //   }
  // }

  @override
  void onInit() async {
    fetchContent().then((value) async {
      if (value != null && value.isNotEmpty) {
        try {
          videoPlayerController = VideoPlayerController.network(value);
          await videoPlayerController?.initialize();
          if (videoPlayerController != null && videoPlayerController!.value.isInitialized) {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController!,
              autoPlay: false,
              looping: false,
              aspectRatio: videoPlayerController?.value.aspectRatio,
              autoInitialize: true,
              allowPlaybackSpeedChanging: false,
              showControlsOnInitialize: false,
            );
            videoPlayerController?.addListener(checkVideo);
          }
        } catch (e) {
          Notify.error('Lỗi khi tải video: $e');
        }
      }
      isLoading.value = false;
      // isLoading.value = true;
      // await subControllerVI?.initial();
      // if (value != null) {
      //   videoPlayerController = VideoPlayerController.network(value);
      //   await videoPlayerController?.initialize();
      //   chewieController = ChewieController(
      //     videoPlayerController: videoPlayerController!,
      //     allowedScreenSleep: false,
      //     // autoPlay: true,
      //     looping: false,
      //     aspectRatio: videoPlayerController?.value.aspectRatio,
      //     autoInitialize: true,
      //     allowPlaybackSpeedChanging: false,
      //     deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      //     subtitle: await getSubtitle(
      //         lang: subControllerVI != null
      //             ? 'vi'
      //             : subControllerEN != null
      //                 ? 'en'
      //                 : null),
      //     subtitleBuilder: (context, subtitle) => Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16),
      //       child: StrokeText(
      //         text: subtitle,
      //         fontSize: 20,
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //     additionalOptions: (context) {
      //       return <OptionItem>[
      //         OptionItem(
      //           onTap: () async {
      //             selectedSubtitle.value = 0;
      //             if (subControllerVI != null) {
      //               chewieController?.subtitle = await getSubtitle(lang: 'vi');
      //             } else {
      //               chewieController?.subtitle = Subtitles([]);
      //             }
      //             Get.back();
      //           },
      //           iconData: Icons.subtitles,
      //           title: 'Tiếng Việt',
      //         ),
      //         OptionItem(
      //           onTap: () async {
      //             selectedSubtitle.value = 1;
      //             if (subControllerEN != null) {
      //               chewieController?.subtitle = await getSubtitle(lang: 'en');
      //             } else {
      //               chewieController?.subtitle = Subtitles([]);
      //             }
      //             Get.back();
      //           },
      //           iconData: Icons.subtitles,
      //           title: 'Tiếng Anh',
      //         ),
      //         OptionItem(
      //           onTap: () {
      //             Get.back();
      //           },
      //           iconData: Icons.close,
      //           title: 'Đóng',
      //         ),
      //       ];
      //     },
      //     optionsBuilder: (context, defaultOptions) async {
      //       await Get.bottomSheet(
      //           ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: defaultOptions.length,
      //             itemBuilder: (_, i) => ListTile(
      //               horizontalTitleGap: 0.0,
      //               leading: Obx(() => selectedSubtitle.value == i
      //                   ? Icon(
      //                       defaultOptions[i].iconData,
      //                       color: kAccentColor,
      //                     )
      //                   : Icon(defaultOptions[i].iconData)),
      //               title: Obx(() => Text(
      //                     defaultOptions[i].title,
      //                     style: TextStyle(
      //                         color: selectedSubtitle.value == i
      //                             ? kAccentColor
      //                             : null),
      //                   )),
      //               onTap: defaultOptions[i].onTap,
      //             ),
      //           ),
      //           backgroundColor: Colors.white);
      //     },
      //   );
      //   videoPlayerController?.addListener(checkVideo);
      // }
      // isLoading.value = false;
    });

    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
