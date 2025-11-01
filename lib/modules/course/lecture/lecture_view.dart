import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'lecture_controller.dart';

class LectureView extends StatelessWidget {
  late final LectureController controller;

  LectureView({Key? key, required CategoryModel category}) : super(key: key) {
    controller = Get.put(LectureController(category: category),
        tag: category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.only(
            top: context.responsive(mobile: 40, desktop: 56),
            left: 16,
            right: 16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 1024),
                child: _boxVideo(),
              ),
              const SizedBox(
                height: 16,
              ),
              context.responsive(
                  mobile: Container(
                    constraints: const BoxConstraints(maxWidth: 1324),
                    child: _boxDuration(context),
                  ),
                  desktop: Container(
                    height: 103 + 64,
                    padding: const EdgeInsets.only(top: 32, bottom: 32),
                    child: _boxDuration(context),
                  ))
            ],
          ),
        ));
  }

  Widget _boxVideo() {
    return BoxBorderGradient(
      borderRadius: BorderRadius.circular(12),
      borderSize: 3,
      child: Obx(() => controller.isLoading.value
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.courseController.unitController.book.value
                                .subjectId ==
                            2
                        ? kPrimaryColor
                        : kAccentColor,
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

  Widget _boxDuration(BuildContext context) {
    return Obx(() => ListView.builder(
        scrollDirection:
            context.responsive(mobile: Axis.vertical, desktop: Axis.horizontal),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listDuration.length,
        itemBuilder: (context, index) => TimelineTile(
              axis: context.responsive(
                  mobile: TimelineAxis.vertical,
                  desktop: TimelineAxis.horizontal),
              indicatorStyle: IndicatorStyle(
                  color: kAccentColor,
                  width: 11,
                  height: 11,
                  indicator: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.courseController.unitController.book
                                    .value.subjectId ==
                                2
                            ? kPrimaryColor
                            : kAccentColor),
                    child: controller.listDuration[index]["status"] == 1
                        ? SvgPicture.asset('assets/icons/tick.svg')
                        : null,
                  )),
              afterLineStyle: LineStyle(
                  color: controller.courseController.unitController.book.value
                              .subjectId ==
                          2
                      ? kPrimaryColor
                      : kAccentColor,
                  thickness: 1),
              beforeLineStyle: LineStyle(
                  color: controller.courseController.unitController.book.value
                              .subjectId ==
                          2
                      ? kPrimaryColor
                      : kAccentColor,
                  thickness: 1),
              endChild: GestureDetector(
                onTap: () => controller.videoPlayerController?.seekTo(
                    controller
                        .parseDuration(controller.listDuration[index]["time"])),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 8, top: 4),
                  height: 48,
                  child: context.responsive(
                      mobile: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _itemDuration(index,
                            isDesktop: false, isActive: false),
                      ),
                      desktop: Padding(
                        padding: const EdgeInsets.only(top: 28, bottom: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          decoration: BoxDecoration(
                              color: controller.listDuration[index]["status"] ==
                                          1 &&
                                      (index ==
                                              controller.listDuration.length -
                                                  1 ||
                                          controller.listDuration[index + 1]
                                                  ["status"] ==
                                              0)
                                  ? (controller.courseController.unitController
                                              .book.value.subjectId ==
                                          2
                                      ? kPrimaryColor
                                      : kAccentColor)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(18)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: _itemDuration(index,
                                isDesktop: true,
                                isActive: controller.listDuration[index]
                                            ["status"] ==
                                        1 &&
                                    (index ==
                                            controller.listDuration.length -
                                                1 ||
                                        controller.listDuration[index + 1]
                                                ["status"] ==
                                            0)),
                          ),
                        ),
                      )),
                ),
              ),
              alignment: TimelineAlign.start,
              isFirst: index == 0,
              isLast: index == controller.listDuration.length - 1,
            )));
  }

  List<Widget> _itemDuration(int index,
      {required bool isDesktop, required bool isActive}) {
    return [
      Text('${controller.listDuration[index]['content']}',
          style: CustomTheme.medium(16)
              .copyWith(color: isActive ? Colors.white : null)),
      isDesktop
          ? const SizedBox(
              height: 4,
            )
          : const SizedBox(),
      Text('${controller.listDuration[index]['time']}',
          style: CustomTheme.medium(16)
              .copyWith(color: isActive ? Colors.white : null))
    ];
  }
}
