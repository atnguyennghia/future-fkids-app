import 'package:futurekids/data/providers/auth_provider.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final userId = Get.arguments['user_id'];

  final txtPassword = TextEditingController();
  final txtPasswordFocusNode = FocusNode();

  final txtRetypePassword = TextEditingController();
  final txtRetypePasswordFocusNode = FocusNode();

  final txtPasswordObscure = true.obs;
  final txtRetypePasswordObscure = true.obs;

  bool validate() {
    if (txtPassword.text.isEmpty) {
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    if (txtRetypePassword.text.isEmpty) {
      txtRetypePasswordFocusNode.requestFocus();
      return false;
    }

    if (txtPassword.text != txtRetypePassword.text) {
      Notify.error('Mật khẩu không trùng khớp');
      txtRetypePasswordFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onUpdate() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final authProvider = AuthProvider();
      final result = await authProvider.resetPassword(userId, txtPassword.text, txtRetypePassword.text).catchError((err) {
        dialog.error(message: err, callback: () => dialog.dismiss());
      });

      if (result != null && result) {
        dialog.succeed(message: 'Đổi mật khẩu thành công!', callback: () {
          dialog.dismiss();
          Get.back();
        });
      }
    }
  }

  @override
  void onClose() {
    txtPasswordFocusNode.dispose();
    txtPassword.dispose();

    txtRetypePasswordFocusNode.dispose();
    txtRetypePassword.dispose();

    super.onClose();
  }
}
