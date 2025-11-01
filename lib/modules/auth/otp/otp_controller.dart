import 'package:futurekids/data/providers/auth_provider.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final email = Get.arguments['email'];

  final txtOTP = TextEditingController();
  final txtOTPFocusNode = FocusNode();

  bool validate() {
    if(txtOTP.text.isEmpty) {
      txtOTPFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onConfirm() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final authProvider = AuthProvider();
      final result = await authProvider.confirmOTP(email, txtOTP.text).catchError((err) {
        dialog.error(message: err, callback: () => dialog.dismiss());
      });

      if (result != null) {
        dialog.dismiss();
        Get.offAndToNamed('/auth/reset-password', arguments: {"user_id": result});
      }
    }
  }

  @override
  void onClose() {
    txtOTPFocusNode.dispose();
    txtOTP.dispose();

    super.onClose();
  }
}
