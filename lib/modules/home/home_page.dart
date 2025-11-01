import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:futurekids/modules/home/recent/recent_view.dart';
import 'package:futurekids/modules/home/widgets/all_subject_widget.dart';
import 'package:futurekids/modules/home/widgets/banner_widget.dart';
import 'package:futurekids/modules/home/widgets/menu_profile.dart';
import 'package:futurekids/modules/home/widgets/subject_widget.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());
  final popupMenuController = CustomPopupMenuController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      route: '/',
      body: SafeArea(
        child: context.responsive(
            mobile: _content(context),
            desktop: SingleChildScrollView(
              child: _content(context),
            )),
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
              context.responsive(
                  mobile: Image.asset(
                    'assets/images/logo.png',
                    width: 53,
                  ),
                  desktop: const SizedBox()),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: AuthService.to.hasLogin
                    ? MenuProfile(
                        popupMenuController: popupMenuController,
                      )
                    : Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.75,
                        child: KButton(
                          width: context.responsive(mobile: 120, desktop: 160),
                          onTap: () => Get.toNamed('/auth/login'),
                          title: 'Đăng nhập',
                          style: CustomTheme.semiBold(
                                  context.responsive(mobile: 15, desktop: 16))
                              .copyWith(color: Colors.white),
                          prefixIcon: Padding(
                            child: Image.asset(
                              'assets/images/key.png',
                              width: 17,
                            ),
                            padding: const EdgeInsets.only(right: 4),
                          ),
                        ),
                      ),
              )),
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
        AuthService.to.hasLogin ? RecentView() : const BannerWidget(),
        AuthService.to.hasLogin
            ? SizedBox(
                height: context.responsive(mobile: 16, desktop: 32),
              )
            : const SizedBox(),
        context.responsive(
            mobile: Expanded(
              child: Obx(() => AuthService.to.profileModel.value.grade == null
                  ? AllSubjectWWidget(controller: controller)
                  : SubjectWidget(
                      controller: controller,
                    )),
            ),
            desktop: Obx(() => AuthService.to.profileModel.value.grade == null
                ? AllSubjectWWidget(controller: controller)
                : SubjectWidget(
                    controller: controller,
                  )))
      ],
    );
  }
}
