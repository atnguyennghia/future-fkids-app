import 'package:archery/views/flame/start_game.dart';
import 'package:futurekids/data/models/game_model.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plan_vs_zombies/views/flame/start_game.dart';
import 'package:swimming_pool/components/animation/fubo_swimming.dart';
import 'package:swimming_pool/views/flame/start_game.dart';

import '../../data/models/category_model.dart';
import '../../data/providers/submit_provider.dart';
import '../../services/auth_service.dart';
import '../../utils/loading_dialog.dart';
import '../lesson/lesson_controller.dart';
import '../unit/unit_controller.dart';

class GameController extends GetxController {
  final game = Get.arguments["game"] as GameModel;
  final category = Get.arguments["category"] as CategoryModel;
  final courseController = Get.find<CourseController>();
  final loadingProcess = 0.0.obs;

  final hideWebView = false.obs;

  void muteVolumeGameAfterConfirmExit() {
    if (game.urlGame.toString().contains('archery')) {
      StartGameArchery.stopBgmMusic();
    } else if (game.urlGame.toString().contains('plan-vs-zombies')) {
      StartGamePlanVsZombies.stopBgmMusic();
    } else if (game.urlGame.toString().contains('swimming-pool')) {
      StartGameSwimmingPool.stopBgmMusic();
      FuboSwimming.stopBgmMusic();
    }
  }

  void exitGame(bool isStudyCompleted) {
    hideWebView.value = true;
    final _dialog = LoadingDialog();
    _dialog.exit(
        isStudyCompleted: isStudyCompleted,
        callback: (confirm) async {
          if (confirm) {
            muteVolumeGameAfterConfirmExit();

            _dialog.dismiss();
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]).then((value) => Get.back());
          } else {
            _dialog.dismiss();
            hideWebView.value = false;
          }
        });
    _dialog.show();
  }

  void submitData(dynamic score) async {
    if (AuthService.to.hasLogin) {
      final _provider = SubmitProvider();
      final _result = await _provider.submitData(
          profileId: AuthService.to.profileModel.value.id,
          courseId: courseController.course.courseId,
          categoryId: category.categoryId,
          contentId: game.id,
          point: score,
          percentComplete: 100);

      if (_result != null && _result) {
        //fetch lại data lesson, unit
        Get.find<LessonController>().fetchLesson();
        Get.find<UnitController>().fetchUnit();
      }
    }
  }
}
