import 'package:futurekids/data/providers/auth_provider.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final txtEmail = TextEditingController();
  final txtEmailFocusNode = FocusNode();

  bool validate() {
    if (txtEmail.text.isEmpty) {
      txtEmailFocusNode.requestFocus();
      return false;
    }

    if (!txtEmail.text.isEmail) {
      Notify.error('Email không đúng định dạng');
      txtEmailFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onSend() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final authProvider = AuthProvider();
      final result = await authProvider.sendEmailOTP(txtEmail.text).catchError((err) {
        dialog.error(message: err, callback: () => dialog.dismiss());
      });

      if (result != null && result) {
        dialog.succeed(message: 'Mã OTP đã được gửi đến Email của bạn\nVui lòng kiểm tra Email để lấy mã OTP', callback: () {
          dialog.dismiss();
          Get.offAndToNamed('/auth/otp', arguments: {"email": txtEmail.text});
        });
      }
    }
  }

  @override
  void onClose() {
    txtEmailFocusNode.dispose();
    txtEmail.dispose();

    super.onClose();
  }
}
