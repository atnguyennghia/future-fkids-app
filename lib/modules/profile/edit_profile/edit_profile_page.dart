import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import 'edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  final controller = Get.put(EditProfileController());

  EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: MainScaffold(
        appBar: const PersonalAppbar(
          title: 'Thông tin tài khoản',
        ),
        background: Background.personal,
        isShowNavigation: false,
        body: Align(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 503),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/button_down_2.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.profile.typeAccount == 0
                              ? 'Tài khoản phụ huynh'
                              : 'Tài khoản con',
                          style: CustomTheme.semiBold(16),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            BoxBorderGradient(
                              boxShape: BoxShape.circle,
                              borderSize: 3,
                              gradientType: GradientType.type3,
                              child: Obx(() => CircleAvatar(
                                    radius: 60,
                                    backgroundImage: controller
                                            .avatar.value.isEmpty
                                        ? (controller.profile.avatar == null ||
                                                controller.profile.avatar
                                                    .toString()
                                                    .isEmpty
                                            ? null
                                            : NetworkImage(
                                                controller.profile.avatar))
                                        : Image.memory(controller.avatar.value)
                                            .image,
                                  )),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => Get.toNamed(
                                      '/profile/select-avatar',
                                      arguments: {"controller": controller}),
                                  child: Container(
                                    width: 29,
                                    height: 29,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: SvgPicture.asset(
                                      'assets/icons/pencil.svg',
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: StrokeText(
                                text: controller.profile.typeAccount == 0
                                    ? 'Thông tin của phụ huynh'
                                    : 'Thông tin của bé'))
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    KTextField(
                      hintText: controller.profile.typeAccount == 0
                          ? 'Họ tên phụ huynh'
                          : 'Họ và tên bé*',
                      controller: controller.txtName,
                      focusNode: controller.txtNameFocusNode,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    controller.profile.typeAccount == 0
                        ? KTextField(
                            hintText: 'Email*',
                            controller: controller.txtEmail,
                            focusNode: controller.txtEmailFocusNode,
                          )
                        : KTextField(
                            hintText: 'Lớp học*',
                            onTap: () => controller.loadCategory(
                                listItem: controller.listGrade
                                    .map((element) => element.toJson())
                                    .toList(),
                                selectedIndex: controller.indexGrade,
                                txtController: controller.txtGrade),
                            controller: controller.txtGrade,
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    controller.profile.typeAccount == 0
                        ? KTextField(
                            hintText: 'Điện thoại*',
                            controller: controller.txtMobile,
                            focusNode: controller.txtMobileFocusNode,
                            listTextInputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]"))
                            ],
                            textInputType: TextInputType.number,
                          )
                        : KTextField(
                            hintText: 'Tuổi*',
                            onTap: () => controller.loadCategory(
                                listItem: controller.listAge,
                                selectedIndex: controller.indexAge,
                                txtController: controller.txtAge),
                            controller: controller.txtAge,
                          ),
                    Visibility(
                        visible: controller.profile.typeAccount != 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: KTextField(
                            hintText: 'Giới tính*',
                            onTap: () => controller.loadCategory(
                                listItem: controller.listGender,
                                selectedIndex: controller.indexGender,
                                txtController: controller.txtGender),
                            controller: controller.txtGender,
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    KTextField(
                      hintText: 'Ngày sinh',
                      onTap: () => controller.showDatePicker(),
                      controller: controller.txtBirthday,
                    ),
                    Visibility(
                      visible: controller.profile.typeAccount == 0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: KTextField(
                          onTap: () => controller.showProvince(),
                          hintText: 'Tỉnh/Thành phố',
                          controller: controller.txtProvince,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: KButton(
          onTap: () => controller.onConfirm(),
          width: 328,
          title: 'Cập nhật',
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
