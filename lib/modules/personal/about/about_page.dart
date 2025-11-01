import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_controller.dart';

class AboutPage extends StatelessWidget {
  final controller = Get.put(AboutController());

  AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Giới thiệu',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          const StrokeText(text: 'Chào mừng bạn đến với'),
          const Spacer(),
          Image.asset('assets/images/logo1.png'),
          const Spacer(),
          Text(
            'Kiến tạo nhân tài Việt',
            style: CustomTheme.semiBold(20).copyWith(color: kPrimaryColor),
          ),
          const Spacer(
            flex: 4,
          ),
          Text(
            'Phiên bản hiện tại: ' +
                (kIsWeb
                    ? kVersionWeb.replaceAll('web_', '')
                    : GetPlatform.isIOS
                        ? kVersionIOS.replaceAll('ios_', '')
                        : kVersionAndroid.replaceAll('android_', '')),
            style: CustomTheme.semiBold(20),
          ),
          Row(
            children: [
              const Spacer(),
              Image.asset(
                'assets/icons/facebook.png',
                width: 48,
              ),
              Image.asset(
                'assets/icons/youtube.png',
                width: 48,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
