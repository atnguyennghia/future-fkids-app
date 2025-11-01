import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());

  ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MainScaffold(
        appBar: const PersonalAppbar(
          title: 'Đổi mật khẩu',
        ),
        background: Background.personal,
        isShowNavigation: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 503),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Đổi mật khẩu mới',
                      style: CustomTheme.semiBold(16),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => KTextField(
                        hintText: 'Mật khẩu cũ*',
                        obscureText: controller.txtPasswordObscure.value,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.txtPasswordObscure.value =
                              !controller.txtPasswordObscure.value,
                          child: controller.txtPasswordObscure.value
                              ? const Icon(CupertinoIcons.eye_slash)
                              : const Icon(CupertinoIcons.eye),
                        ),
                        controller: controller.txtPassword,
                        focusNode: controller.txtPasswordFocusNode,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => KTextField(
                        hintText: 'Nhập mật khẩu mới*',
                        obscureText: controller.txtPasswordNewObscure.value,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.txtPasswordNewObscure.value =
                              !controller.txtPasswordNewObscure.value,
                          child: controller.txtPasswordNewObscure.value
                              ? const Icon(CupertinoIcons.eye_slash)
                              : const Icon(CupertinoIcons.eye),
                        ),
                        controller: controller.txtPasswordNew,
                        focusNode: controller.txtPasswordNewFocusNode,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => KTextField(
                        hintText: 'Nhập lại mật khẩu mới*',
                        obscureText:
                            controller.txtPasswordNewRetypeObscure.value,
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              controller.txtPasswordNewRetypeObscure.value =
                                  !controller.txtPasswordNewRetypeObscure.value,
                          child: controller.txtPasswordNewRetypeObscure.value
                              ? const Icon(CupertinoIcons.eye_slash)
                              : const Icon(CupertinoIcons.eye),
                        ),
                        controller: controller.txtPasswordNewRetype,
                        focusNode: controller.txtPasswordNewRetypeFocusNode,
                      )),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: KButton(
          onTap: () => controller.onSubmit(),
          width: 328,
          title: 'Cập nhật',
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
