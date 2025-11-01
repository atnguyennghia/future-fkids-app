import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'exercise_list_controller.dart';

class ExerciseListView extends StatelessWidget {
  late final ExerciseListController controller;

  ExerciseListView({Key? key, required CategoryModel category})
      : super(key: key) {
    controller = Get.put(ExerciseListController(category: category),
        tag: category.categoryId.toString());
  }

  void goExercisePage({required int index}) {
    controller.selectedIndex = index;

    Get.toNamed('/exercise', arguments: {
      "exercise": controller.listExercise[index],
      "category": controller.category
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.listExercise.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: kAccentColor,
            ),
          )
        : ListView.separated(
            primary: false,
            padding: EdgeInsets.only(
                top: context.responsive(mobile: 40, desktop: 56),
                left: 16,
                right: 16,
                bottom: 16),
            itemCount: controller.listExercise.length,
            itemBuilder: (context, index) => context.responsive(
                mobile: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: kWidthMobile * 2),
                    child: _buildItem(context, index),
                  ),
                ),
                desktop: index % 2 == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: kWidthMobile,
                            child: _buildItem(context, index),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          index + 1 < controller.listExercise.length
                              ? SizedBox(
                                  width: kWidthMobile,
                                  child: _buildItem(context, index + 1),
                                )
                              : const SizedBox(
                                  width: kWidthMobile,
                                )
                        ],
                      )
                    : const SizedBox()),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
          ));
  }

  Widget _buildItem(context, index) {
    return GestureDetector(
      onTap: () => goExercisePage(index: index),
      child: BoxBorderGradient(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 2),
              color: Color.fromRGBO(0, 0, 0, .25),
              blurRadius: 4)
        ],
        child: Row(
          children: [
            Image.asset(
              'assets/avatars/fubo_exercise_${index % 5}.png',
              height: 88,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Center(
              child: Text(
                '${controller.listExercise[index].title}',
                style: CustomTheme.semiBold(16),
                textAlign: TextAlign.center,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
