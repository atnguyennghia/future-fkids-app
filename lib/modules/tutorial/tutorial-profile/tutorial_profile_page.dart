import 'package:futurekids/modules/tutorial/tutorial-profile/tutorial_profile_controller.dart';
import 'package:futurekids/modules/tutorial/widgets/scale_animation_widget.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/color_palette.dart';
import '../../../services/auth_service.dart';
import '../../../utils/custom_theme.dart';
import '../../../widgets/base_scaffold.dart';
import '../../../widgets/box_border_gradient.dart';
import '../../../widgets/stroke_text.dart';
import '../../profile/widgets/avatar_widget.dart';

class TutorialProfilePage extends StatelessWidget {
  final controller = Get.put(TutorialProfileController());
  TutorialProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          BaseScaffold(
            body: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const StrokeText(
                        text: 'Hãy chọn tài khoản để vào học nhé!'),
                    const SizedBox(
                      height: 32,
                    ),
                    Obx(() => Opacity(
                          opacity: controller.step.value == 1 ? 0.0 : 1.0,
                          child: BoxBorderGradient(
                            boxShape: BoxShape.circle,
                            borderSize: 3,
                            gradientType: GradientType.type3,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AuthService.to.userModel.value
                                          .profile?[0].avatar ==
                                      null
                                  ? Image.asset('assets/avatars/0.png').image
                                  : NetworkImage(
                                      '${AuthService.to.userModel.value.profile?[0].avatar}'),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${AuthService.to.userModel.value.profile?[0].name}',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Obx(() => Opacity(
                          opacity: controller.step.value == 1 ? 1.0 : 0.0,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 596),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  AuthService.to.userModel.value.profile != null
                                      ? [
                                          AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    1
                                                ? AuthService.to.userModel.value
                                                    .profile![1].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    1
                                                ? '${AuthService.to.userModel.value.profile?[1].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                          AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    2
                                                ? AuthService.to.userModel.value
                                                    .profile![2].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    2
                                                ? '${AuthService.to.userModel.value.profile?[2].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                          AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    3
                                                ? AuthService.to.userModel.value
                                                    .profile![3].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    3
                                                ? '${AuthService.to.userModel.value.profile?[3].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                        ]
                                      : [],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Opacity(
                    opacity: 0.0,
                    child:
                        StrokeText(text: 'Hãy chọn tài khoản để vào học nhé!'),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() => Opacity(
                        opacity: controller.step.value == 1 ? 1.0 : 0.0,
                        child: ScaleAnimationWidget(
                          child: BoxBorderGradient(
                            boxShape: BoxShape.circle,
                            borderSize: 3,
                            gradientType: GradientType.type3,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AuthService.to.userModel.value
                                          .profile?[0].avatar ==
                                      null
                                  ? Image.asset('assets/avatars/0.png').image
                                  : NetworkImage(
                                      '${AuthService.to.userModel.value.profile?[0].avatar}'),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: Text(
                      '${AuthService.to.userModel.value.profile?[0].name}',
                      style: CustomTheme.semiBold(16)
                          .copyWith(color: kNeutral2Color),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() => Opacity(
                        opacity: controller.step.value == 1 ? 0.0 : 1.0,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 596),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                AuthService.to.userModel.value.profile != null
                                    ? [
                                        ScaleAnimationWidget(
                                          child: AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    1
                                                ? AuthService.to.userModel.value
                                                    .profile![1].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    1
                                                ? '${AuthService.to.userModel.value.profile?[1].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                        ),
                                        ScaleAnimationWidget(
                                          child: AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    2
                                                ? AuthService.to.userModel.value
                                                    .profile![2].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    2
                                                ? '${AuthService.to.userModel.value.profile?[2].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                        ),
                                        ScaleAnimationWidget(
                                          child: AvatarWidget(
                                            avatarUrl: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    3
                                                ? AuthService.to.userModel.value
                                                    .profile![3].avatar
                                                : null,
                                            title: AuthService.to.userModel
                                                        .value.profile!.length >
                                                    3
                                                ? '${AuthService.to.userModel.value.profile?[3].name}'
                                                : 'Tài khoản phụ',
                                          ),
                                        ),
                                      ]
                                    : [],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: SizedBox(
              width: 344,
              height: 137,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: 316,
                    height: 137,
                    padding: const EdgeInsets.only(
                        top: 7, left: 61, right: 7, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() => Text(
                                controller.step.value == 1
                                    ? 'Đầu tiên là tài khoản dành cho phụ huynh. Với tài khoản này, phụ huynh có thể trải nghiệm tất cả khóa học và theo dõi thành tích của con thông qua bảng xếp hạng'
                                    : 'Tiếp đến là tài khoản phụ cho các con học tập. Tại đây, phụ huynh có thể tạo tối đa 3 tài khoản phụ cho con. Hãy click vào dấu + để tạo tài khoản nhé!',
                                style: CustomTheme.regular(14),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => controller.onCancel(),
                              child: Text(
                                'Bỏ qua',
                                style: CustomTheme.semiBold(12)
                                    .copyWith(color: kAccentColor),
                              ),
                            ),
                            const SizedBox(
                              width: 48,
                            ),
                            KButton(
                              onTap: controller.onContinue,
                              title: 'Tiếp tục',
                              width: 104.62,
                              height: 34,
                              backgroundColor: BackgroundColor.accent,
                              style: CustomTheme.semiBold(12)
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/fubo.png',
                        width: 74,
                        height: 113,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
