import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/course_scaffold.dart';
import 'package:futurekids/widgets/progress_bar.dart';
import 'package:futurekids/widgets/score_star.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'unit_controller.dart';

class UnitPage extends StatelessWidget {
  final controller = Get.put(UnitController());

  UnitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      subjectId: controller.book.value.subjectId,
      title: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${controller.book.value.name}'.toUpperCase(),
              style: CustomTheme.semiBold(18).copyWith(color: Colors.white),
            ),
          )),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () => controller.onBookClick(),
            child: BoxBorderGradient(
              borderRadius: BorderRadius.circular(12),
              width: context.responsive(mobile: 167, desktop: 220),
              height: 37,
              color: Colors.white.withOpacity(0.4),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Obx(() => Text(
                          '${controller.book.value.description}',
                          style: CustomTheme.semiBold(18)
                              .copyWith(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        )),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset('assets/icons/button_down_2.svg'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Obx(
        () => controller.listUnit.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              )
            : context.responsive(
                mobile: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: kWidthMobile),
                      child: _listItem(),
                    )),
                desktop: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 520,
                    child: _listItem(isDesktop: true),
                  ),
                )),
      ),
    );
  }

  Widget _listItem({bool isDesktop = false}) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: isDesktop ? Axis.horizontal : Axis.vertical,
        padding: const EdgeInsets.all(16),
        itemCount: controller.listUnit.length,
        separatorBuilder: (context, index) => SizedBox(
              width: isDesktop ? 60 : null,
            ),
        itemBuilder: (context, index) => Align(
              alignment:
                  index % 2 == 0 ? Alignment.topLeft : Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => Get.toNamed('/lesson', arguments: {
                  "unit": controller.listUnit[index],
                  "avatar":
                      'assets/avatars/${controller.book.value.subjectId}_${index % 6}.png'
                }),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    index == 0
                        ? const SizedBox()
                        : context.responsive(
                            mobile: Positioned(
                                top: -120,
                                left: index % 2 == 0 ? 60 : -60,
                                child: Image.asset(
                                  index % 2 == 0
                                      ? 'assets/images/line_1.png'
                                      : 'assets/images/line_0.png',
                                  width: 160,
                                )),
                            desktop: Positioned(
                                top: index % 2 != 0 ? -120 : null,
                                bottom: index % 2 == 0
                                    ? (controller.book.value.subjectId == 3
                                        ? -120
                                        : -60)
                                    : null,
                                left: -120,
                                child: Image.asset(
                                  index % 2 == 0
                                      ? 'assets/images/line_1.png'
                                      : 'assets/images/line_0.png',
                                  width: 160,
                                ))),
                    Image.asset(
                      'assets/avatars/${controller.book.value.subjectId}_${index % 6}.png',
                      width: 144,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 178,
                          height: 130,
                          color: Colors.transparent,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            BoxBorderGradient(
                              width: 178,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StrokeText(
                                    text: '${controller.listUnit[index].name}',
                                    fontSize: 18,
                                  ),
                                  const Divider(),
                                  Visibility(
                                      visible: controller
                                              .listUnit[index].description !=
                                          null,
                                      child: Text(
                                        '${controller.listUnit[index].description}',
                                        style: CustomTheme.medium(16),
                                      ))
                                ],
                              ),
                            ),
                            Visibility(
                                visible: controller.listUnit[index].isLock == 1,
                                child: Positioned.fill(
                                    child: BoxBorderGradient(
                                  borderRadius: BorderRadius.circular(12),
                                  color: kNeutral3Color.withOpacity(0.8),
                                  gradientType: GradientType.type5,
                                ))),
                            Visibility(
                                visible: controller.listUnit[index].isLock == 1,
                                child: Positioned(
                                  bottom: -4,
                                  right: -4,
                                  child: Image.asset(
                                    'assets/icons/lock.png',
                                    width: 37,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                    Positioned(
                        top: 118,
                        left: 32,
                        child: ProgressBar(
                          percent: controller.listUnit[index].percentComplete,
                        )),
                    Positioned(
                        top: 95,
                        left: 0,
                        child: ScoreStar(
                          totalPoint:
                              controller.listUnit[index].totalPoint.round(),
                          point: controller.listUnit[index].point.round(),
                        )),
                    Obx(() {
                      if (controller.listUnit[index].status == 0) {
                        controller.activeUnitIndex.value == index;
                      }
                      return controller.activeUnitIndex.value == index
                          ? Positioned(
                              top: 55,
                              right: 0,
                              child: Image.asset(
                                'assets/icons/active_icon_${controller.book.value.subjectId}_${index % 2}.png',
                                width: 64,
                              ))
                          : const SizedBox();
                    }),
                  ],
                ),
              ),
            ));
  }
}
