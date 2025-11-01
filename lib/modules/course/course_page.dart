import 'package:futurekids/modules/course/article/article_view.dart';
import 'package:futurekids/modules/course/exercise_list/exercise_list_view.dart';
import 'package:futurekids/modules/course/game/game_view.dart';
import 'package:futurekids/modules/course/lecture/lecture_view.dart';
import 'package:futurekids/modules/course/pronunciation/pronunciation_view.dart';
import 'package:futurekids/modules/course/review/review_view.dart';
import 'package:futurekids/modules/course/vocabulary/vocabulary_view.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:futurekids/widgets/course_scaffold.dart';
import 'course_controller.dart';

class CoursePage extends StatelessWidget {
  final controller = Get.put(CourseController());

  CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CourseScaffold(
      subjectId: controller.unitController.book.value.subjectId,
      title: Text(
        '${controller.course.name}. ${controller.course.description ?? ''}',
        style: CustomTheme.semiBold(18).copyWith(color: Colors.white),
        maxLines: 2,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Container(
                  height: 26,
                  color: Colors.transparent,
                ),
                Expanded(
                    child: BoxBorderGradient(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white.withOpacity(0.5),
                  borderSize: 1,
                  child: Obx(() => IndexedStack(
                        index: controller.selectedCategory.value,
                        children: [
                          ...List.generate(controller.listCategory.length,
                              (index) {
                            switch (
                                controller.listCategory[index].contentType) {
                              case "1":
                                return LectureView(
                                    category: controller.listCategory[index]);
                              case "2":
                                return ArticleView(
                                    category: controller.listCategory[index]);
                              case "3":
                                return ExerciseListView(
                                    category: controller.listCategory[index]);
                              case "4":
                                return GameView(
                                    category: controller.listCategory[index]);
                              case "5":
                                return ReviewView(
                                    category: controller.listCategory[index]);
                              case "6":
                                return VocabularyView(
                                    category: controller.listCategory[index]);
                              case "7":
                                return PronunciationView(
                                    category: controller.listCategory[index]);
                            }
                            return const SizedBox();
                          })
                        ],
                      )),
                ))
              ],
            ),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                        controller.listCategory.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                onTap: () =>
                                    controller.selectedCategory.value = index,
                                child: Container(
                                  height:
                                      controller.selectedCategory.value == index
                                          ? 54
                                          : 50,
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        controller.selectedCategory.value ==
                                                index
                                            ? 86
                                            : 80,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/backgrounds/button${controller.selectedCategory.value == index ? '_active' : ''}_${controller.unitController.book.value.subjectId}.png'),
                                          fit: BoxFit.fill),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                            spreadRadius: 0,
                                            color: Color.fromRGBO(0, 0, 0, .25))
                                      ]),
                                  child: Center(
                                    child: Text(
                                      '${controller.listCategory[index].categoryName}',
                                      style: CustomTheme.semiBold(15)
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
