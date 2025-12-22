import 'package:archery/views/flame/start_game.dart';
import 'package:flutter/rendering.dart';
import 'package:futurekids/data/models/game_model.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plan_vs_zombies/views/flame/start_game.dart';
import 'package:swimming_pool/components/animation/fubo_swimming.dart';
import 'package:swimming_pool/views/flame/start_game.dart';
import 'package:webview_flutter/webview_flutter.dart' as wv;

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
  wv.WebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    // Force landscape for bundled Flame games (designed 1920x1080)
    if (_isFlameGame) {
      _setLandscape();
    }
  }

  Future<void> ensureGameOrientation() async {
    if (_isFlameGame) {
      await _setLandscape();
      // allow a short delay for orientation to apply before rendering
      await Future.delayed(const Duration(milliseconds: 120));
    }
  }

  Future<void> _setLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void muteVolumeGameAfterConfirmExit() {
    // Always try stopping all known game BGMs first (covers unknown games too)
    StartGameArchery.stopBgmMusic();
    StartGamePlanVsZombies.stopBgmMusic();
    StartGameSwimmingPool.stopBgmMusic();
    FuboSwimming.stopBgmMusic();

    // Stop any webview-based game audio by loading a blank page
    webViewController?.loadRequest(Uri.parse('about:blank'));

    // If game is known, you can add any extra clean-up per type here
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
            debugPrint('exitGame 123: $confirm ${game.urlGame}');
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

  @override
  void onClose() {
    // Restore portrait when leaving the game
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onClose();
  }

  bool get _isFlameGame =>
      game.urlGame.toString().contains('archery') ||
      game.urlGame.toString().contains('plan-vs-zombies') ||
      game.urlGame.toString().contains('swimming-pool');
}
