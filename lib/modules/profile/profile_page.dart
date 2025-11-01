import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/profile/widgets/avatar_widget.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileController());

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Obx(() => controller.status.value == 0
              ? const CircularProgressIndicator(
                  color: kAccentColor,
                )
              : controller.status.value == 401
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const StrokeText(
                            text: 'Phiên đăng nhập cũ đã hết hạn!'),
                        const SizedBox(
                          height: 32,
                        ),
                        KButton(
                          title: 'Đăng nhập',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: Colors.white),
                          onTap: () {
                            AuthService.to.logout();
                            Get.offAllNamed('/auth/login');
                          },
                          width: 138,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StrokeText(
                            text: 'Hãy chọn tài khoản để vào học nhé!'),
                        const SizedBox(
                          height: 32,
                        ),
                        GestureDetector(
                          onTap: () {
                            final profile = AuthService.to.userModel.value.profile;
                            if (profile != null && profile.isNotEmpty) {
                              controller.onSelectProfile(profile[0]);
                            }
                          },
                          child: BoxBorderGradient(
                            boxShape: BoxShape.circle,
                            borderSize: 3,
                            gradientType: GradientType.type3,
                            child: Obx(() => CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AuthService.to.userModel
                                              .value.profile?[0].avatar ==
                                          null
                                      ? Image.asset('assets/avatars/0.png')
                                          .image
                                      : NetworkImage(
                                          '${AuthService.to.userModel.value.profile?[0].avatar}'),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(() => Text(
                              '${AuthService.to.userModel.value.profile?[0].name}',
                              style: CustomTheme.semiBold(16)
                                  .copyWith(color: kNeutral2Color),
                            )),
                        const SizedBox(
                          height: 32,
                        ),
                        Obx(() {
                          final profile = AuthService.to.userModel.value.profile;
                          if (profile == null || profile.length <= 1) {
                            return const SizedBox.shrink();
                          }
                          return Container(
                            constraints: const BoxConstraints(maxWidth: 596),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (profile.length > 1)
                                  AvatarWidget(
                                    avatarUrl: profile[1].avatar,
                                    title: profile[1].name ?? 'Tài khoản phụ',
                                    onTap: () => controller.onSelectProfile(profile[1]),
                                  ),
                                if (profile.length > 2)
                                  AvatarWidget(
                                    avatarUrl: profile[2].avatar,
                                    title: profile[2].name ?? 'Tài khoản phụ',
                                    onTap: () => controller.onSelectProfile(profile[2]),
                                  ),
                                if (profile.length > 3)
                                  AvatarWidget(
                                    avatarUrl: profile[3].avatar,
                                    title: profile[3].name ?? 'Tài khoản phụ',
                                    onTap: () => controller.onSelectProfile(profile[3]),
                                  ),
                              ],
                            ),
                          );
                        })
                      ],
                    )),
        ),
      ),
    );
  }
}
