import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'contact_controller.dart';

class ContactPage extends StatelessWidget {
  final controller = Get.put(ContactController());

  ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Liên hệ',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 622),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/contact_girl.png',
                      width: 48,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hỗ trợ cùng FutureKids',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kNeutral2Color),
                        ),
                        Text(
                          'Hãy đặt câu hỏi cho chúng tôi',
                          style: CustomTheme.medium(12).copyWith(
                            color: kNeutral2Color,
                          ),
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    KButton(
                      onTap: () => controller.openUrl(
                          'https://www.facebook.com/Futurekids-108002788845299/'),
                      width: 80,
                      height: 32,
                      title: 'Chat ngay',
                      style: CustomTheme.semiBold(14)
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/cskh.png',
                      width: 48,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trung tâm CSKH',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kNeutral2Color),
                        ),
                        Text(
                          '1920 252586',
                          style: CustomTheme.medium(12)
                              .copyWith(color: kNeutral2Color),
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () => controller.openUrl('tel:1920252586'),
                      child: Text(
                        'LIÊN HỆ',
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: kPrimaryColor),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/email.png',
                      width: 48,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kNeutral2Color),
                        ),
                        Text(
                          'contact@futurekids.edu.vn',
                          style: CustomTheme.medium(12)
                              .copyWith(color: kNeutral2Color),
                        )
                      ],
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () => controller
                          .openUrl('mailto:contact@futurekids.edu.vn'),
                      child: Text(
                        'LIÊN HỆ',
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: kPrimaryColor),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
