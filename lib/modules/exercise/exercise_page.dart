import 'package:futurekids/modules/exercise/ex_matching/ex_matching_view.dart';
import 'package:futurekids/modules/exercise/ex_other/ex_other_view.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/exercise_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'exercise_controller.dart';

class ExercisePage extends StatelessWidget {
  final controller = Get.put(ExerciseController());

  ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: ExerciseScaffold(
        exerciseName: '${controller.exercise.title}',
        body: FutureBuilder(
          future: controller.fetchQuestion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (controller.listQuestion.isEmpty) {
                return Center(
                  child: Text(
                    'Không có dữ liệu!',
                    style: CustomTheme.semiBold(16),
                  ),
                );
              }
              if (controller.listQuestion.first.type == '5') {
                return ExMatchingView();
              }
              return ExOtherView();
            }
            return const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
