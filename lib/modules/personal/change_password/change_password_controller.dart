import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final txtPassword = TextEditingController();
  final txtPasswordNew = TextEditingController();
  final txtPasswordNewRetype = TextEditingController();

  final txtPasswordFocusNode = FocusNode();
  final txtPasswordNewFocusNode = FocusNode();
  final txtPasswordNewRetypeFocusNode = FocusNode();

  final txtPasswordObscure = true.obs;
  final txtPasswordNewObscure = true.obs;
  final txtPasswordNewRetypeObscure = true.obs;

  bool validate() {
    if (txtPassword.text.isEmpty) {
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    if (txtPasswordNew.text.isEmpty) {
      txtPasswordNewFocusNode.requestFocus();
      return false;
    }

    if (txtPasswordNewRetype.text.isEmpty) {
      txtPasswordNewRetypeFocusNode.requestFocus();
      return false;
    }

    if (txtPassword.text.length < 6 || txtPassword.text.length > 20) {
      Notify.error('Mật khẩu cần có độ dài từ 6 - 20 ký tự');
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    if (txtPasswordNew.text.length < 6 || txtPasswordNew.text.length > 20) {
      Notify.error('Mật khẩu cần có độ dài từ 6 - 20 ký tự');
      txtPasswordNewFocusNode.requestFocus();
      return false;
    }

    if (txtPasswordNewRetype.text.length < 6 ||
        txtPasswordNewRetype.text.length > 20) {
      Notify.error('Mật khẩu cần có độ dài từ 6 - 20 ký tự');
      txtPasswordNewRetypeFocusNode.requestFocus();
      return false;
    }

    if (txtPasswordNewRetype.text != txtPasswordNew.text) {
      Notify.error('Mật khẩu không khớp');
      txtPasswordNewRetypeFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onSubmit() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final provider = UserProvider();
      final result = await provider
          .updatePassword(
              passwordOld: txtPassword.text,
              passwordNew: txtPasswordNew.text,
              passwordConfirm: txtPasswordNewRetype.text)
          .catchError((err) {
        dialog.dismiss();
        Notify.error(err);
      });

      if (result != null && result) {
        dialog.dismiss();
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    txtPassword.dispose();
    txtPasswordNew.dispose();
    txtPasswordNewRetype.dispose();

    txtPasswordFocusNode.dispose();
    txtPasswordNewFocusNode.dispose();
    txtPasswordNewRetypeFocusNode.dispose();
    super.onClose();
  }
}
