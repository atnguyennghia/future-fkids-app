import 'package:futurekids/data/providers/auth_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final txtEmail = TextEditingController();
  final txtEmailFocusNode = FocusNode();

  final txtPassword = TextEditingController();
  final txtPasswordFocusNode = FocusNode();

  final txtPasswordObscure = true.obs;

  final recentUsername = ''.obs;

  bool validate() {
    if (txtEmail.text.isEmpty) {
      txtEmailFocusNode.requestFocus();
      return false;
    }

    if (txtPassword.text.isEmpty) {
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onLogin() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final authProvider = AuthProvider();
      final result = await authProvider
          .login(txtEmail.text, txtPassword.text)
          .catchError((err) {
        dialog.error(message: err, callback: () => dialog.dismiss());
      });

      if (result != null) {
        dialog.dismiss();

        AuthService.to.login(result, txtEmail.text);

        Get.offAllNamed('/profile');
      }
    }
  }

  @override
  void onReady() {
    txtEmail.text = GetStorage().read('username') ?? '';
    recentUsername.value = txtEmail.text;
    super.onReady();
  }

  @override
  void onClose() {
    txtEmailFocusNode.dispose();
    txtEmail.dispose();

    txtPasswordFocusNode.dispose();
    txtPassword.dispose();

    super.onClose();
  }
}
