import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/home/recent/recent_controller.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuProfile extends StatelessWidget {
  final CustomPopupMenuController popupMenuController;

  const MenuProfile({Key? key, required this.popupMenuController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var listMenu = <dynamic>[null, null, null];
      final listProfile = AuthService.to.userModel.value.profile;
      if (listProfile == null) {
        return const SizedBox.shrink();
      }
      var indexMenu = 0;
      for (int i = 0; i < listProfile.length; i++) {
        if (listProfile[i].id == AuthService.to.profileModel.value.id) {
          continue;
        }
        listMenu[indexMenu] = i;
        indexMenu++;
      }
      return CustomPopupMenu(
          controller: popupMenuController,
          showArrow: false,
          verticalMargin: 0.0,
          horizontalMargin: 0.0,
          barrierColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BoxBorderGradient(
                borderSize: 1.0,
                width: 200,
                height: 48,
                color: const Color(0xFFbbecfd),
                padding: const EdgeInsets.only(left: 8, right: 8),
                gradientType: GradientType.type2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AuthService.to.profileModel.value.name}',
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: kNeutral2Color),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        AuthService.to.profileModel.value.grade == 0
                            ? 'Tiền tiểu học'
                            : AuthService.to.profileModel.value.grade == null
                                ? 'Phụ huynh'
                                : '${AuthService.to.profileModel.value.className}',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kNeutral2Color),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: -16,
                  top: -2,
                  child: BoxBorderGradient(
                    borderSize: 3,
                    boxShape: BoxShape.circle,
                    child: CircleAvatar(
                      radius: 23.5,
                      backgroundImage: AuthService
                                  .to.profileModel.value.avatar ==
                              null
                          ? Image.asset('assets/avatars/0.png').image
                          : NetworkImage(
                              '${AuthService.to.profileModel.value.avatar}'),
                    ),
                  ))
            ],
          ),
          menuBuilder: () => Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background_menu.png'),
                        fit: BoxFit.fill)),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Chuyển tài khoản',
                          style: CustomTheme.semiBold(18).copyWith(
                            color: kNeutral2Color,
                          ),
                        ),
                      ),
                      const Divider(
                        color: kNeutral2Color,
                        thickness: 1,
                      ),
                      ...List.generate(3, (index) {
                        if (listMenu[index] != null) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  final profile = AuthService.to.userModel.value.profile;
                                  final menuIndex = listMenu[index];
                                  if (profile != null && menuIndex != null && menuIndex < profile.length) {
                                    AuthService.to.saveProfileModel(profile[menuIndex]);
                                    popupMenuController.hideMenu();
                                    Get.find<RecentController>().fetchStudying();
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AuthService.to.userModel.value.profile?[listMenu[index]].name}',
                                        style: CustomTheme.medium(16)
                                            .copyWith(color: kNeutral2Color),
                                      ),
                                      Text(
                                        AuthService
                                                    .to
                                                    .userModel
                                                    .value
                                                    .profile?[listMenu[index]]
                                                    .grade ==
                                                0
                                            ? 'Tiền tiểu học'
                                            : AuthService
                                                        .to
                                                        .userModel
                                                        .value
                                                        .profile?[
                                                            listMenu[index]]
                                                        .grade ==
                                                    null
                                                ? 'Phụ huynh'
                                                : '${AuthService.to.userModel.value.profile?[listMenu[index]].className}',
                                        style: CustomTheme.medium(16).copyWith(
                                          color: kNeutral2Color,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              index == 2
                                  ? const SizedBox()
                                  : const Divider(
                                      color: kNeutral3Color,
                                      thickness: 0.5,
                                    )
                            ],
                          );
                        }
                        return Column(
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () {
                                popupMenuController.hideMenu();
                                Get.toNamed('/profile/select-avatar');
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Thêm tài khoản',
                                    style: CustomTheme.medium(16)
                                        .copyWith(color: kNeutral2Color),
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: kNeutral2Color,
                                  )
                                ],
                              ),
                            ),
                            index == 2
                                ? const SizedBox()
                                : const Divider(
                                    color: kNeutral3Color,
                                    thickness: 0.5,
                                  )
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
          pressType: PressType.singleClick);
    });
  }
}
