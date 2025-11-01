import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'setting_controller.dart';

class SettingPage extends StatelessWidget {
  final controller = Get.put(SettingController());

  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(title: 'Cài đặt'),
      isShowNavigation: false,
      background: Background.personal,
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 576),
            child: Column(
              children: [
                Obx(
                  () => SwitchListTile.adaptive(
                    activeColor: kPrimaryColor,
                    value: controller.valueSwitch.value,
                    onChanged: (value) => controller.valueSwitch.value = value,
                    title: Text(
                      'Thông báo nhắc giờ học',
                      style: CustomTheme.semiBold(16),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.showDatePicker(),
                  child: BoxBorderGradient(
                    width: 255,
                    height: 42,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Obx(
                        () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('a').format(
                                            controller.timeValue.value) ==
                                        'AM'
                                    ? 'Sáng'
                                    : 'Chiều',
                                style: CustomTheme.semiBold(16)
                                    .copyWith(color: kPrimaryColor),
                              ),
                              Text(
                                '${DateFormat('hh').format(controller.timeValue.value)} Giờ',
                                style: CustomTheme.semiBold(16)
                                    .copyWith(color: kPrimaryColor),
                              ),
                              Text(
                                '${DateFormat('mm').format(controller.timeValue.value)} Phút',
                                style: CustomTheme.semiBold(16)
                                    .copyWith(color: kPrimaryColor),
                              )
                            ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: KButton(
                onTap: () => controller.save(),
                width: 328,
                title: 'Cập nhật',
                style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
              ),
              minimum: const EdgeInsets.all(16),
            )
          ],
        ),
      ),
    );
  }
}
