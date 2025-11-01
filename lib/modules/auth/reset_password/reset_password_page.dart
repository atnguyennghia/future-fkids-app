import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/auth_scaffold.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'reset_password_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  final controller = Get.put(ResetPasswordController());

  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AuthScaffold(
        automaticallyImplyLeading: true,
        body: Column(
          children: [
            const StrokeText(
              text: 'Lấy lại mật khẩu',
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(() => KTextField(
                  hintText: 'Nhập mật khẩu*',
                  obscureText: controller.txtPasswordObscure.value,
                  prefixIcon: const Icon(CupertinoIcons.lock),
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
                  hintText: 'Nhập lại mật khẩu*',
                  obscureText: controller.txtRetypePasswordObscure.value,
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.txtRetypePasswordObscure.value =
                        !controller.txtRetypePasswordObscure.value,
                    child: controller.txtRetypePasswordObscure.value
                        ? const Icon(CupertinoIcons.eye_slash)
                        : const Icon(CupertinoIcons.eye),
                  ),
                  controller: controller.txtRetypePassword,
                  focusNode: controller.txtRetypePasswordFocusNode,
                )),
            const SizedBox(
              height: 16,
            ),
            KButton(
              onTap: () => controller.onUpdate(),
              title: 'Cập nhật',
              style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
