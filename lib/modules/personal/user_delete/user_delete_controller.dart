import 'package:futurekids/data/providers/reason_provider.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/color_palette.dart';
import '../../../utils/custom_theme.dart';
import '../../../widgets/k_button.dart';

class UserDeleteController extends GetxController {
  final listReasons = [].obs;
  final selectedIndex = 0.obs;
  final txtPassword = TextEditingController();
  final txtPasswordFN = FocusNode();

  void fetchListReason() async {
    final _provider = ReasonProvider();
    final _result = await _provider.getListResons().catchError((err) {
      printError(info: err.toString());
      Notify.error(err.toString());
    });

    if (_result != null) {
      listReasons.value = _result;
    }
  }

  void showConfirm() {
    final _dialog = LoadingDialog();
    _dialog.custom(
      loadingWidget: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 344,
            padding:
                const EdgeInsets.only(top: 60, bottom: 16, left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sau khi xóa tài khoản tất cả dữ liệu cá nhân cũng như tiến trình học, thành tích, quà tặng, ... của bạn sẽ bị xóa. Sau khi xóa xong, bạn không thể hoàn tác.',
                  textAlign: TextAlign.center,
                  style: CustomTheme.medium(16).copyWith(
                    color: kNeutral2Color,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Bạn có chắc chắn muốn xóa tài khoản không?',
                  textAlign: TextAlign.center,
                  style: CustomTheme.semiBold(16).copyWith(
                    color: kNeutral2Color,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                KTextField(
                  hintText: 'Nhập mật khẩu để xác nhận',
                  radius: 12,
                  controller: txtPassword,
                  focusNode: txtPasswordFN,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: KButton(
                        onTap: () => _dialog.dismiss(),
                        title: 'Huỷ',
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: Colors.white),
                        width: double.infinity,
                        backgroundColor: BackgroundColor.disable,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: KButton(
                        onTap: () => onConfirm(_dialog),
                        title: 'Xác nhận',
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: Colors.white),
                        width: double.infinity,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/fubo_error.gif',
                width: 118.18,
                height: 131.13,
              )),
        ],
      ),
    );
  }

  bool validate() {
    if (txtPassword.text.isEmpty) {
      txtPasswordFN.requestFocus();
      return false;
    }

    return true;
  }

  void onConfirm(LoadingDialog dialog) async {
    if (validate()) {
      dialog.dismiss();

      final _dialog = LoadingDialog();
      _dialog.show();

      final _provider = UserProvider();
      final _result = await _provider
          .deleteUser(
              reason: listReasons[selectedIndex.value],
              password: txtPassword.text)
          .catchError((err) {
        _dialog.dismiss();
        printError(info: err.toString());
        Notify.error(err.toString());
      });

      if (_result != null && _result) {
        _dialog.dismiss();

        AuthService.to.logout();
        Get.offAndToNamed('/home');
      }
    }
  }

  @override
  void onInit() {
    fetchListReason();
    super.onInit();
  }

  @override
  void onClose() {
    txtPasswordFN.dispose();
    txtPassword.dispose();
    super.onClose();
  }
}
