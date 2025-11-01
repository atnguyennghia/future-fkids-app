import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:futurekids/modules/home/home_controller.dart';
import 'package:futurekids/modules/tutorial/tutorial-home/tutorial_home_controller.dart';
import 'package:futurekids/modules/tutorial/widgets/menu_profile_tutorial.dart';
import 'package:futurekids/modules/tutorial/widgets/reccent_view_tutorial.dart';
import 'package:futurekids/modules/tutorial/widgets/scale_animation_widget.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_service.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/custom_theme.dart';
import '../../../widgets/k_button.dart';
import '../../../widgets/main_scaffold.dart';
import '../../home/recent/recent_view.dart';
import '../../home/widgets/all_subject_widget.dart';
import '../../home/widgets/banner_widget.dart';
import '../../home/widgets/menu_profile.dart';
import '../widgets/bottom_navigation_tutorial.dart';
import '../widgets/sidebar_navigation_tutorial.dart';

class TutorialHomePage extends StatelessWidget {
  final controller = Get.put(TutorialHomeController());
  final homecontroller = Get.put(HomeController());
  final popupMenuController = CustomPopupMenuController();
  TutorialHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() => MainScaffold(
                route: '/',
                isShowNavigation: controller.step.value > 3 ? false : true,
                body: SafeArea(
                  child: context.responsive(
                      mobile: _content(context),
                      desktop: SingleChildScrollView(
                        child: _content(context),
                      )),
                ),
              )),
          Positioned.fill(
              child: Obx(() => Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.65),
                    body: SafeArea(
                        child: context.responsive(
                            mobile: _contentOverlay(context),
                            desktop: Row(
                              children: [
                                controller.step.value > 3
                                    ? SidebarNavigationTutorial(
                                        route: '/',
                                        pointerPosition:
                                            controller.step.value - 3,
                                      )
                                    : const SizedBox(),
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: _contentOverlay(context),
                                ))
                              ],
                            ))),
                    bottomNavigationBar: context.responsive(
                        mobile: controller.step.value > 3
                            ? BottomNavigationTutorial(
                                pointerPosition: controller.step.value - 3,
                              )
                            : const SizedBox(),
                        desktop: const SizedBox()),
                  ))),
          Obx(() => Positioned(
                bottom: controller.step.value < 3 ? 80 : null,
                top: controller.step.value == 3 ? 52 : null,
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
                              child: Obx(() => Center(
                                    child: Text(
                                      controller.getTextByStep(),
                                      style: CustomTheme.regular(14),
                                    ),
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
              ))
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Opacity(
                opacity: 1.0,
                child: context.responsive(
                    mobile: Image.asset(
                      'assets/images/logo.png',
                      width: 53,
                    ),
                    desktop: const SizedBox()),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => Opacity(
                      opacity: controller.step.value == 1 ? 0.0 : 1.0,
                      child: MenuProfile(
                        popupMenuController: popupMenuController,
                      ),
                    ),
                  ),
                ),
              ),
              AuthService.to.hasLogin
                  ? const SizedBox(
                      width: 12,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Opacity(
            opacity: controller.step.value == 2 ? 0.0 : 1.0,
            child:
                AuthService.to.hasLogin ? RecentView() : const BannerWidget(),
          ),
        ),
        AuthService.to.hasLogin
            ? SizedBox(
                height: context.responsive(mobile: 16, desktop: 32),
              )
            : const SizedBox(),
        context.responsive(
          mobile: Expanded(
            child: Obx(() => Opacity(
                  opacity: controller.step.value == 3 ? 0.0 : 1.0,
                  child: AllSubjectWWidget(
                    controller: homecontroller,
                    isTutorial: true,
                  ),
                )),
          ),
          desktop: Obx(() => Opacity(
                opacity: controller.step.value == 3 ? 0.0 : 1.0,
                child: AllSubjectWWidget(
                  controller: homecontroller,
                  isTutorial: true,
                ),
              )),
        )
      ],
    );
  }

  Widget _contentOverlay(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Opacity(
                opacity: 0.0,
                child: context.responsive(
                    mobile: Image.asset(
                      'assets/images/logo.png',
                      width: 53,
                    ),
                    desktop: const SizedBox()),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => controller.step.value == 1
                        ? ScaleAnimationWidget(
                            child: MenuProfileTutorial(
                              popupMenuController: popupMenuController,
                            ),
                          )
                        : const SizedBox(
                            height: 48,
                          ),
                  ),
                ),
              ),
              AuthService.to.hasLogin
                  ? const SizedBox(
                      width: 12,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Opacity(
            opacity: controller.step.value == 2 ? 1.0 : 0.0,
            child: AuthService.to.hasLogin
                ? const RecentViewTutorial()
                : const BannerWidget(),
          ),
        ),
        AuthService.to.hasLogin
            ? SizedBox(
                height: context.responsive(mobile: 16, desktop: 32),
              )
            : const SizedBox(),
        context.responsive(
          mobile: Expanded(
            child: Obx(() => Opacity(
                  opacity: controller.step.value == 3 ? 1.0 : 0.0,
                  child: AllSubjectWWidget(
                    controller: homecontroller,
                    isTutorial: true,
                  ),
                )),
          ),
          desktop: Obx(() => Opacity(
                opacity: controller.step.value == 3 ? 1.0 : 0.0,
                child: AllSubjectWWidget(
                  controller: homecontroller,
                  isTutorial: true,
                ),
              )),
        )
      ],
    );
  }
}
