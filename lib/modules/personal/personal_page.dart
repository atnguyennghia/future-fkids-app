import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/services/setting_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'personal_controller.dart';

class PersonalPage extends StatelessWidget {
  final controller = Get.put(PersonalController());

  PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      background: Background.personal,
      route: '/personal',
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            'Cá nhân',
            style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(0.4),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: BoxBorderGradient(
              gradientType: GradientType.type2,
              borderSize: 1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 593),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tài khoản',
                    style: CustomTheme.semiBold(16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BoxBorderGradient(
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                    gradientType: GradientType.type2,
                    child: Column(
                      children: [
                        _buildItem(
                            icon: 'person',
                            title: 'Thông tin tài khoản',
                            onTap: () => Get.toNamed('/personal/account-info')),
                        _buildItem(
                            icon: 'card',
                            title: 'Thẻ và kích hoạt thẻ',
                            onTap: () => Get.toNamed('/personal/card')),
                        _buildItem(
                            icon: 'lock',
                            title: 'Đổi mật khẩu',
                            onTap: () =>
                                Get.toNamed('/personal/change-password')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Hỗ trợ',
                    style: CustomTheme.semiBold(16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BoxBorderGradient(
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(8),
                    color: Colors.white.withOpacity(0.4),
                    gradientType: GradientType.type2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        kIsWeb
                            ? const SizedBox()
                            : _buildItem(
                                icon: 'setting',
                                title: 'Cài đặt',
                                onTap: () => Get.toNamed('/personal/setting'),
                              ),
                        _buildItem(
                            icon: 'help',
                            title: 'Hướng dẫn',
                            onTap: () => Get.toNamed('/personal/guide')),
                        SettingService.to.isShowActiveCard
                            ? _buildItem(
                                icon: 'mail',
                                title: 'Liên hệ',
                                onTap: () => Get.toNamed('/personal/contact'))
                            : const SizedBox(),
                        _buildItem(
                            icon: 'rule',
                            title: 'Điều khoản',
                            onTap: () => Get.toNamed(
                                  '/regulation/rule',
                                )),
                      ],
                    ),
                  ),
                  SettingService.to.isShowActiveCard
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: BoxBorderGradient(
                            borderRadius: BorderRadiusDirectional.circular(12),
                            color: Colors.white.withOpacity(0.4),
                            gradientType: GradientType.type2,
                            padding: const EdgeInsets.all(12),
                            child: InkWell(
                              onTap: () => Get.toNamed('/personal/about'),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/info_2.svg'),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text('Về FutureKids',
                                        style: CustomTheme.semiBold(16)),
                                  )),
                                  Image.asset(
                                    'assets/icons/facebook.png',
                                    width: 15,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    'assets/icons/google.png',
                                    width: 15,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    'assets/icons/youtube.png',
                                    width: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 16,
                        ),
                  BoxBorderGradient(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                    gradientType: GradientType.type2,
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        AuthService.to.logout();
                        Get.offAllNamed('/');
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/logout.svg'),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Đăng xuất',
                              style: CustomTheme.semiBold(16),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      {required String icon, required String title, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/$icon.svg'),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title,
                style: CustomTheme.medium(16).copyWith(color: kNeutral2Color),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
