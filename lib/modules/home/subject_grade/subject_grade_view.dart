import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'subject_grade_controller.dart';

class SubjectGradeView extends StatelessWidget {
  late final SubjectGradeController controller;

  final bool isTutorial;

  SubjectGradeView(
      {Key? key, required dynamic subjectId, this.isTutorial = false})
      : super(key: key) {
    controller = Get.put(SubjectGradeController(subjectId: subjectId),
        tag: subjectId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.listSubjectGrade.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          )
        : context.responsive(
            desktop: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => controller.carouselController.previousPage(),
                      child: Image.asset(
                        'assets/icons/left.png',
                        width: 43,
                        height: 68,
                      ),
                    ),
                    const SizedBox(
                      width: 48,
                    ),
                    SizedBox(
                      width: 880,
                      height: 470,
                      child: CarouselSlider.builder(
                        carouselController: controller.carouselController,
                        itemCount:
                            (controller.listSubjectGrade.length / 6).ceil(),
                        itemBuilder: (context, index, realIndex) =>
                            GridView.count(
                          mainAxisSpacing: 50,
                          crossAxisSpacing: 51,
                          childAspectRatio: 260 / 210,
                          children: List.generate(
                              index ==
                                      (controller.listSubjectGrade.length / 6)
                                              .ceil() -
                                          1
                                  ? (controller.listSubjectGrade.length -
                                      (index * 6))
                                  : controller.listSubjectGrade.length < 6
                                      ? controller.listSubjectGrade.length
                                      : 6,
                              (index1) => _itemBuilder(
                                  context, index * 6 + index1, 24.0)),
                          crossAxisCount: 3,
                        ),
                        options: CarouselOptions(
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, _) =>
                                controller.currentIndex.value = index),
                      ),
                    ),
                    const SizedBox(
                      width: 48,
                    ),
                    InkWell(
                      onTap: () => controller.carouselController.nextPage(),
                      child: Image.asset(
                        'assets/icons/right.png',
                        width: 43,
                        height: 68,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                DotsIndicator(
                  dotsCount: (controller.listSubjectGrade.length / 6).ceil(),
                  position: controller.currentIndex.value.roundToDouble(),
                  onTap: (index) => controller.carouselController
                      .animateToPage(index.round()),
                  decorator: const DotsDecorator(
                      color: Colors.white,
                      activeColor: kAccentColor,
                      spacing: EdgeInsets.all(15),
                      size: Size(20, 20),
                      activeSize: Size(20, 20)),
                )
              ],
            ),
            mobile: Container(
              constraints: const BoxConstraints(maxWidth: kWidthMobile),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 150 / 120,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) =>
                    _itemBuilder(context, index, 12.0),
                itemCount: controller.listSubjectGrade.length,
              ),
            )));
  }

  Widget _itemBuilder(context, index, radius) {
    return InkWell(
      onTap: () => isTutorial
          ? null
          : controller.onGradeClick(
              gradeId: controller.listSubjectGrade[index].gradeId),
      child: BoxBorderGradient(
        borderRadius: BorderRadius.circular(radius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            '${controller.listSubjectGrade[index].image}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
