import 'package:futurekids/data/providers/auth_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/helper.dart';

class RegisterController extends GetxController {
  final txtFullName = TextEditingController();
  final txtFullNameFocusNode = FocusNode();

  final txtEmail = TextEditingController();
  final txtEmailFocusNode = FocusNode();

  final txtPhone = TextEditingController();
  final txtPhoneFocusNode = FocusNode();

  final txtPassword = TextEditingController();
  final txtPasswordFocusNode = FocusNode();

  final txtRetypePassword = TextEditingController();
  final txtRetypePasswordFocusNode = FocusNode();

  final txtPasswordObscure = true.obs;
  final txtRetypePasswordObscure = true.obs;

  bool validate() {
    if (txtFullName.text.isEmpty) {
      txtFullNameFocusNode.requestFocus();
      return false;
    }

    if (txtEmail.text.isEmpty) {
      txtEmailFocusNode.requestFocus();
      return false;
    }

    if (txtPhone.text.isEmpty) {
      txtPhoneFocusNode.requestFocus();
      return false;
    }

    if (txtPassword.text.isEmpty) {
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    if (txtRetypePassword.text.isEmpty) {
      txtRetypePasswordFocusNode.requestFocus();
      return false;
    }

    if (!txtEmail.text.trim().isEmail) {
      Notify.error('Email không đúng định dạng');
      txtEmailFocusNode.requestFocus();
      return false;
    }

    if (!Helper.instance.isValidPhone(txtPhone.text.trim())) {
      Notify.error('Số điện thoại không đúng định dạng');
      txtPhoneFocusNode.requestFocus();
      return false;
    }

    if (txtPassword.text.length < 6 || txtPassword.text.length > 20) {
      Notify.error('Mật khẩu cần có độ dài từ 6 - 20 ký tự');
      txtPasswordFocusNode.requestFocus();
      return false;
    }

    if (txtRetypePassword.text.length < 6 ||
        txtRetypePassword.text.length > 20) {
      Notify.error('Mật khẩu cần có độ dài từ 6 - 20 ký tự');
      txtRetypePasswordFocusNode.requestFocus();
      return false;
    }

    if (txtRetypePassword.text != txtPassword.text) {
      Notify.error('Mật khẩu không khớp');
      txtRetypePasswordFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void _login() async {
    final _dialog = LoadingDialog();
    _dialog.show();
    final _provider = AuthProvider();
    final _result = await _provider
        .login(
      txtEmail.text.trim(),
      txtPassword.text.trim(),
    )
        .catchError((err) {
      _dialog.error(message: err, callback: () => _dialog.dismiss());
      printError(info: err.toString());
    });

    if (_result != null) {
      _dialog.dismiss();
      AuthService.to.login(_result, txtEmail.text.trim());
      Get.offAllNamed('/profile');
    }
  }

  void onRegisterClick() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final authProvider = AuthProvider();
      final result = await authProvider
          .register(txtFullName.text.trim(), txtEmail.text.trim(),
              txtPhone.text.trim(), txtPassword.text)
          .catchError((err) {
        dialog.error(message: err, callback: () => dialog.dismiss());
      });

      if (result != null && result) {
        dialog.dismiss();
        _login();
      }
    }
  }

  @override
  void onClose() {
    txtFullNameFocusNode.dispose();
    txtFullName.dispose();

    txtEmailFocusNode.dispose();
    txtEmail.dispose();

    txtPhoneFocusNode.dispose();
    txtPhone.dispose();

    txtPasswordFocusNode.dispose();
    txtPassword.dispose();

    txtRetypePasswordFocusNode.dispose();
    txtRetypePassword.dispose();

    super.onClose();
  }
}
