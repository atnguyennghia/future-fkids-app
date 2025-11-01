import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/home/home_controller.dart';
import 'package:futurekids/modules/home/subject_grade/subject_grade_view.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:futurekids/utils/extension.dart';

class AllSubjectWWidget extends StatelessWidget {
  final HomeController controller;

  final bool isTutorial;

  const AllSubjectWWidget(
      {Key? key, required this.controller, this.isTutorial = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() => BoxBorderGradient(
                constraints: const BoxConstraints(maxWidth: 464),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 3),
                      spreadRadius: 2,
                      blurRadius: 4),
                ],
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () => controller.selectedIndex.value = 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                context.responsive(mobile: 16, desktop: 28)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 0
                              ? kAccentColor
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24)),
                        ),
                        child: Text(
                          'Toán',
                          style: CustomTheme.semiBold(
                                  context.responsive(mobile: 18, desktop: 20))
                              .copyWith(
                                  color: controller.selectedIndex.value == 0
                                      ? Colors.white
                                      : kNeutral2Color),
                        ),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => controller.selectedIndex.value = 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                context.responsive(mobile: 16, desktop: 28)),
                        alignment: Alignment.center,
                        color: controller.selectedIndex.value == 1
                            ? kAccentColor
                            : Colors.white,
                        child: Text('Tiếng Việt',
                            style: CustomTheme.semiBold(
                                    context.responsive(mobile: 18, desktop: 20))
                                .copyWith(
                                    color: controller.selectedIndex.value == 1
                                        ? Colors.white
                                        : kNeutral2Color)),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => controller.selectedIndex.value = 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                context.responsive(mobile: 16, desktop: 28)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: controller.selectedIndex.value == 2
                                ? kAccentColor
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(24),
                                bottomRight: Radius.circular(24))),
                        child: Text('Tiếng Anh',
                            style: CustomTheme.semiBold(
                                    context.responsive(mobile: 18, desktop: 20))
                                .copyWith(
                                    color: controller.selectedIndex.value == 2
                                        ? Colors.white
                                        : kNeutral2Color)),
                      ),
                    )),
                  ],
                ),
              )),
        ),
        SizedBox(
          height: context.responsive(mobile: 16, desktop: 32),
        ),
        context.responsive(
            mobile: Expanded(
                child: Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1066),
                        child: IndexedStack(
                          index: controller.selectedIndex.value,
                          children: List.generate(
                              3,
                              (index) => SubjectGradeView(
                                    subjectId: index + 1,
                                    isTutorial: isTutorial,
                                  )),
                        ),
                      ),
                    ))),
            desktop: Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1066),
                    child: IndexedStack(
                      index: controller.selectedIndex.value,
                      children: List.generate(
                          3,
                          (index) => SubjectGradeView(
                                subjectId: index + 1,
                                isTutorial: isTutorial,
                              )),
                    ),
                  ),
                )))
      ],
    );
  }
}
