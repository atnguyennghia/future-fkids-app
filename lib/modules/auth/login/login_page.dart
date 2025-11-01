import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/auth_scaffold.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        child: AuthScaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Đăng nhập',
                  style: CustomTheme.semiBold(16).copyWith(
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline)),
              GestureDetector(
                onTap: () => Get.offAndToNamed('/auth/register'),
                child: Text('Đăng ký',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color)),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          KTextField(
            prefixIcon: const Icon(CupertinoIcons.phone),
            hintText: 'Số điện thoại hoặc email',
            controller: controller.txtEmail,
            focusNode: controller.txtEmailFocusNode,
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() => KTextField(
                prefixIcon: const Icon(CupertinoIcons.lock),
                hintText: 'Nhập mật khẩu',
                suffixIcon: GestureDetector(
                  onTap: () => controller.txtPasswordObscure.value =
                      !controller.txtPasswordObscure.value,
                  child: controller.txtPasswordObscure.value
                      ? const Icon(CupertinoIcons.eye_slash)
                      : const Icon(CupertinoIcons.eye),
                ),
                obscureText: controller.txtPasswordObscure.value,
                controller: controller.txtPassword,
                focusNode: controller.txtPasswordFocusNode,
              )),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed('/auth/forgot-password'),
                  child: Text(
                    'Quên mật khẩu?',
                    style: CustomTheme.semiBold(16)
                        .copyWith(color: kNeutral2Color),
                  ),
                ),
                Obx(() => Visibility(
                    visible: controller.recentUsername.value.isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        controller.txtEmail.text = '';
                        controller.recentUsername.value = '';
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Đăng nhập bằng tài khoản khác',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kNeutral2Color),
                        ),
                      ),
                    ))),
              ],
            ),
          ),
          KButton(
            onTap: () => controller.onLogin(),
            title: 'Đăng Nhập',
            style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
            width: 138,
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() => Visibility(
              visible: controller.recentUsername.isEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bạn chưa có tài khoản?',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAndToNamed('/auth/register'),
                    child: Text(
                      'Đăng ký',
                      style: CustomTheme.semiBold(16).copyWith(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )))
        ],
      ),
    ));
  }
}
