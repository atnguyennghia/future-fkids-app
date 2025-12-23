import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/auth_service.dart';

class TutorialProfileController extends GetxController {
  final step = 1.obs;

  void onContinue() {
    if (step.value == 1) {
      step.value = 2;
    } else {
      final profile = AuthService.to.userModel.value.profile;
      if (profile != null && profile.isNotEmpty) {
        AuthService.to.saveProfileModel(profile[0]);
        Get.offAndToNamed('/tutorial-home');
      }
    }
  }

  void onCancel() {
    GetStorage().write('first_login', 1);
    Get.offAllNamed('/profile');
  }
}
