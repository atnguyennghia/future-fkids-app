import 'package:futurekids/data/models/lesson_model.dart';
import 'package:futurekids/modules/lesson/widgets/status_bar.dart';
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
import 'package:get/get.dart';

import 'lesson_controller.dart';

class LessonPage extends StatelessWidget {
  final controller = Get.put(LessonController());

  LessonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      subjectId: controller.unitController.book.value.subjectId,
      title: Text(
        '${controller.unitController.book.value.name} > ${controller.unit.name}',
        style: CustomTheme.semiBold(18).copyWith(color: Colors.white),
      ),
      body: Obx(() => controller.listLesson.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: kAccentColor,
              ),
            )
          : context.responsive(
              mobile: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: kWidthMobile * 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: _buildUnitInfo(),
                      ),
                      Expanded(child: _listItem())
                    ],
                  ),
                ),
              ),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: _buildUnitInfoDesktop(),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 32),
                    width: 685,
                    child: _listItem(),
                  )
                ],
              ))),
    );
  }

  Widget _buildUnitInfoDesktop() {
    return BoxBorderGradient(
      width: 299,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Image.asset(
                controller.avatar,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 32),
              child: Stack(
                children: [
                  const SizedBox(
                    width: 290,
                    height: 70,
                  ),
                  ScoreStar(
                    width: 70,
                    height: 70,
                    point: controller.unit.point.round(),
                    totalPoint: controller.unit.totalPoint.round(),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 60,
                      child: ProgressBar(
                        percent: controller.unit.percentComplete,
                        width: 220,
                        height: 32,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: StrokeText(
                text: '${controller.unit.name}',
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${controller.unit.description ?? ''}',
                style: CustomTheme.semiBold(20),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listItem() {
    return ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        itemBuilder: (context, index) => Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 76,
                      width: double.infinity,
                      color: Colors.transparent,
                    ),
                    Obx(() => Visibility(
                        visible: controller.listLesson[index].isExpanded!,
                        child:
                            _buildLessonContent(controller.listLesson[index])))
                  ],
                ),
                Positioned(
                    child: _buildLessonHeader(controller.listLesson[index])),
                Visibility(
                    visible: controller.listLesson[index].isLock == 1,
                    child: Positioned.fill(
                        child: InkWell(
                      onTap: () => controller.onClickedWhenLock(),
                      child: BoxBorderGradient(
                        borderRadius: BorderRadius.circular(12),
                        color: kNeutral3Color.withOpacity(0.5),
                        gradientType: GradientType.type5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/lock.png',
                              width: 65,
                            )
                          ],
                        ),
                      ),
                    )))
              ],
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: controller.listLesson.length);
  }

  Widget _buildUnitInfo() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Row(
          children: [
            Container(
              width: 70,
              height: 155,
              color: Colors.transparent,
            ),
            Expanded(
                child: Container(
              height: 160,
              padding: const EdgeInsets.only(top: 32),
              child: BoxBorderGradient(
                padding: const EdgeInsets.only(
                    left: 80, right: 8, top: 8, bottom: 8),
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StrokeText(
                      text: '${controller.unit.name}',
                      fontSize: 18,
                    ),
                    const Divider(
                      height: 4,
                    ),
                    Visibility(
                        visible: controller.unit.description != null,
                        child: Text(
                          '${controller.unit.description}',
                          style: CustomTheme.semiBold(16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                        ))
                  ],
                ),
              ),
            ))
          ],
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              controller.avatar,
              height: 144,
            )),
        Positioned(
            right: 8,
            top: 20,
            child: ProgressBar(
              percent: controller.unit.percentComplete,
            )),
        Positioned(
            right: 146,
            child: ScoreStar(
              point: controller.unit.point.round(),
              totalPoint: controller.unit.totalPoint.round(),
            ))
      ],
    );
  }

  Widget _buildLessonHeader(LessonModel lessonModel) {
    return GestureDetector(
      onTap: () {
        lessonModel.isExpanded = !lessonModel.isExpanded!;
        controller.listLesson.refresh();
      },
      child: BoxBorderGradient(
        padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
        height: 84,
        width: double.infinity,
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 2),
              blurRadius: 4)
        ],
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${lessonModel.name}:',
                        style: CustomTheme.semiBold(18)),
                    Visibility(
                        visible: lessonModel.description != null,
                        child: Text(
                          '${lessonModel.description}',
                          style: CustomTheme.semiBold(16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ))
                  ],
                )),
                Column(
                  children: [
                    ScoreStar(
                      totalPoint: lessonModel.totalPoint.round(),
                      point: lessonModel.point.round(),
                      showScore: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    StrokeText(
                      text:
                          '${lessonModel.point.round()}/${lessonModel.totalPoint.round()}',
                      borderColor: const Color(0xFF074675),
                      color: Colors.white,
                      fontSize: 10,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: StatusBar(
                  height: 4,
                  percent: lessonModel.percentComplete,
                )),
                const SizedBox(
                  width: 8,
                ),
                Text('${lessonModel.percentComplete.round()}%',
                    style:
                        CustomTheme.semiBold(8).copyWith(color: kNeutral2Color))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLessonContent(LessonModel lessonModel) {
    return BoxBorderGradient(
      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
      width: double.infinity,
      color: Colors.white.withOpacity(0.8),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lessonModel.courses.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.toNamed('/course', arguments: {
                  "lesson": lessonModel,
                  "course": lessonModel.courses[index]
                }),
                child: Column(
                  children: [
                    Row(
                      children: [
                        lessonModel.courses[index].image != null
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.network(
                                    lessonModel.courses[index].image))
                            : const SizedBox(),
                        Expanded(
                            child: Text(
                          '${lessonModel.courses[index].name}. ${lessonModel.courses[index].description ?? ''}',
                          style: CustomTheme.medium(16),
                        )),
                        Column(
                          children: [
                            ScoreStar(
                              totalPoint:
                                  lessonModel.courses[index].totalPoint.round(),
                              point: lessonModel.courses[index].point.round(),
                              width: 26,
                              height: 26,
                            ),
                            Text(
                              '${lessonModel.courses[index].percentComplete.round()}%',
                              style: CustomTheme.semiBold(8)
                                  .copyWith(color: kNeutral3Color),
                            )
                          ],
                        )
                      ],
                    ),
                    StatusBar(
                        height: 2,
                        percent: lessonModel.courses[index].percentComplete),
                    const SizedBox(
                      height: 8,
                    )
                  ],
                ),
              )),
    );
  }
}
