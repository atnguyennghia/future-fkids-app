import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/auth_scaffold.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'otp_controller.dart';

class OtpPage extends StatelessWidget {
  final controller = Get.put(OtpController());

  OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AuthScaffold(
        automaticallyImplyLeading: true,
        body: Column(
          children: [
            const StrokeText(
              text: 'Nhập mã OTP',
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  top: 16, bottom: 8, left: 16, right: 16),
              child: Text(
                'Vui lòng nhập mã OTP được gửi đến Email',
                style: CustomTheme.medium(16).copyWith(color: kNeutral2Color),
              ),
            ),
            KTextField(
              hintText: 'Nhập mã OTP*',
              prefixIcon: const Icon(CupertinoIcons.number),
              controller: controller.txtOTP,
              focusNode: controller.txtOTPFocusNode,
            ),
            const SizedBox(
              height: 16,
            ),
            KButton(
              onTap: () => controller.onConfirm(),
              title: 'Xác nhận',
              style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
