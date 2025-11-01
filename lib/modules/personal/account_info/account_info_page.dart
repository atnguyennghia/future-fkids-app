import 'package:futurekids/data/models/profile_model.dart';
import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/button_edit.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'account_info_controller.dart';

class AccountInfoPage extends StatelessWidget {
  final controller = Get.put(AccountInfoController());

  AccountInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Thông tin tài khoản',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 617),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Obx(() => Column(
                    children: [
                      InkWell(
                        onTap: () => controller.isExpand0.value =
                            !controller.isExpand0.value,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              controller.isExpand0.value
                                  ? 'assets/icons/button_down_2.svg'
                                  : 'assets/icons/button_next.svg',
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Tài khoản phụ huynh',
                              style: CustomTheme.semiBold(16),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: controller.isExpand0.value,
                          child: Obx(() {
                            final profile = AuthService.to.userModel.value.profile;
                            if (profile != null && profile.isNotEmpty) {
                              return _buildItemInfo(profile: profile[0]);
                            }
                            return const SizedBox.shrink();
                          }))
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              Obx(() => Column(
                    children: [
                      InkWell(
                        onTap: () => controller.isExpand1.value =
                            !controller.isExpand1.value,
                        child: Row(
                          children: [
                            SvgPicture.asset(controller.isExpand1.value
                                ? 'assets/icons/button_down_2.svg'
                                : 'assets/icons/button_next.svg'),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Tài khoản con',
                              style: CustomTheme.semiBold(16),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: controller.isExpand1.value,
                          child: Obx(() {
                            final profile = AuthService.to.userModel.value.profile;
                            if (profile == null || profile.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Column(
                              children: List.generate(profile.length, (index) {
                                if (index == 0) {
                                  return const SizedBox();
                                }
                                return _buildItemInfo(profile: profile[index]);
                              }),
                            );
                          }))
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () => Get.toNamed('/personal/user-delete'),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/user-delete.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Xóa tài khoản',
                      style: CustomTheme.semiBold(16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        final profile = AuthService.to.userModel.value.profile;
        if (profile == null || profile.length >= 4) {
          return const SizedBox.shrink();
        }
        return KButton(
          onTap: () => Get.toNamed('/profile/select-avatar'),
          width: 328,
          title: 'Thêm tài khoản con',
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
        );
      }),
    );
  }

  Widget _buildItemInfo({required ProfileModel profile}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BoxBorderGradient(
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(8),
        color: Colors.white.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                BoxBorderGradient(
                  boxShape: BoxShape.circle,
                  child: CircleAvatar(
                    backgroundImage: profile.avatar == null
                        ? null
                        : NetworkImage('${profile.avatar}'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Text(
                  '${profile.name}',
                  style: CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                )),
                const SizedBox(
                  width: 8,
                ),
                ButtonEdit(
                  onTap: () => Get.toNamed('/profile/edit-profile',
                      arguments: {"profile": profile}),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Họ tên',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color)),
                  Text(
                    '${profile.name}',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                  )
                ],
              ),
            ),

            ///Phụ huynh
            Visibility(
              visible: profile.grade == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    Text(
                      '${AuthService.to.userModel.value.email}',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: profile.grade == null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Điện thoại',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kNeutral2Color),
                      ),
                      Text(
                        '${AuthService.to.userModel.value.mobile}',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kNeutral2Color),
                      )
                    ],
                  ),
                )),

            ///Học sinh
            Visibility(
              visible: profile.grade != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lớp',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    Text(
                      profile.className ?? '--',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: profile.grade != null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tuổi',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kNeutral2Color),
                      ),
                      Text(
                        '${profile.age} tuổi',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kNeutral2Color),
                      )
                    ],
                  ),
                )),
            Visibility(
              visible: profile.grade != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giới tính',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    Text(
                      profile.gender == 0
                          ? 'Nữ'
                          : profile.gender == 1
                              ? 'Nam'
                              : 'Khác',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ngày sinh',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                  ),
                  Text(
                    '${profile.birthday ?? '--'}',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                  )
                ],
              ),
            ),
            Visibility(
              visible: profile.grade == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tỉnh/Thành phố',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    Text(
                      '${profile.provinceName ?? '--'}',
                      style: CustomTheme.medium(16)
                          .copyWith(color: kNeutral2Color),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
