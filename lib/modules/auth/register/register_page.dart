import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/auth_scaffold.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  final controller = Get.put(RegisterController());

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AuthScaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Get.offAndToNamed('/auth/login'),
                  child: Text('Đăng nhập',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color)),
                ),
                Text('Đăng ký',
                    style: CustomTheme.semiBold(16).copyWith(
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            KTextField(
              prefixIcon: const Icon(CupertinoIcons.person_crop_circle),
              hintText: 'Họ và tên phụ huynh*',
              controller: controller.txtFullName,
              focusNode: controller.txtFullNameFocusNode,
            ),
            const SizedBox(
              height: 8,
            ),
            KTextField(
              prefixIcon: const Icon(CupertinoIcons.mail),
              hintText: 'Nhập Email*',
              controller: controller.txtEmail,
              focusNode: controller.txtEmailFocusNode,
            ),
            const SizedBox(
              height: 8,
            ),
            KTextField(
              prefixIcon: const Icon(CupertinoIcons.phone),
              hintText: 'Nhập số điện thoại*',
              controller: controller.txtPhone,
              focusNode: controller.txtPhoneFocusNode,
              listTextInputFormatter: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                LengthLimitingTextInputFormatter(12),
              ],
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(() => KTextField(
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  hintText: 'Nhập mật khẩu*',
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
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  hintText: 'Nhập lại mật khẩu*',
                  obscureText: controller.txtRetypePasswordObscure.value,
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
              onTap: () => controller.onRegisterClick(),
              title: 'Đăng Ký',
              style: CustomTheme.semiBold(16).copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn đã có tài khoản?',
                  style: CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => Get.offAndToNamed('/auth/login'),
                  child: Text(
                    'Đăng nhập',
                    style: CustomTheme.semiBold(16).copyWith(
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bằng việc đăng ký bạn đã đồng ý với ',
                  style: CustomTheme.medium(12).copyWith(color: kNeutral2Color),
                ),
                InkWell(
                  onTap: () => Get.toNamed('/regulation/rule'),
                  child: Text(
                    'điều khoản',
                    style: CustomTheme.medium(12).copyWith(
                        decoration: TextDecoration.underline,
                        color: kNeutral2Color),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'và ',
                  style: CustomTheme.medium(12).copyWith(color: kNeutral2Color),
                ),
                InkWell(
                  onTap: () => Get.toNamed('/regulation/policy'),
                  child: Text(
                    'chính sách bảo mật thông tin',
                    style: CustomTheme.medium(12).copyWith(
                        decoration: TextDecoration.underline,
                        color: kNeutral2Color),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
