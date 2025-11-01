import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';

import 'user_delete_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDeletePage extends StatelessWidget {
  final controller = Get.put(UserDeleteController());
  UserDeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBar: const PersonalAppbar(title: 'Xoá tài khoản'),
        background: Background.personal,
        isShowNavigation: false,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Tại sao bạn ngừng sử dụng Fkids',
                  style: CustomTheme.semiBold(18),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Align(
                    child: BoxBorderGradient(
                        constraints: const BoxConstraints(maxWidth: 596),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(() => ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                itemBuilder: (context, index) =>
                                    Obx(() => RadioListTile(
                                          value: index,
                                          groupValue:
                                              controller.selectedIndex.value,
                                          onChanged: (int? value) {
                                            controller.selectedIndex.value =
                                                value!;
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          activeColor: kPrimaryColor,
                                          title: Text(
                                            '${controller.listReasons[index]}',
                                            style: CustomTheme.medium(16)
                                                .copyWith(
                                                    color: kNeutral2Color),
                                          ),
                                        )),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.white,
                                ),
                                itemCount: controller.listReasons.length,
                              )),
                        )),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                minimum: const EdgeInsets.all(16),
                child: KButton(
                  title: 'Tiếp tục',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                  onTap: () => controller.showConfirm(),
                  width: 328,
                ),
              ),
            ],
          ),
        ));
  }
}
