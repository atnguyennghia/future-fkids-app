import 'dart:ui';

import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guide_controller.dart';

class GuidePage extends StatelessWidget {
  final controller = Get.put(GuideController());

  GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Hướng dẫn',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: InkWell(
                  onTap: () => controller
                      .openUrl('https://www.fkids.edu.vn/huongdansudungapp'),
                  child: BoxBorderGradient(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/avatars/fubo_game_1.png',
                          width: 65,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          'Hướng dẫn sử dụng App',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kPrimaryColor),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: InkWell(
                  onTap: () => controller
                      .openUrl('https://www.fkids.edu.vn/huongdanhochieuqua'),
                  child: BoxBorderGradient(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/avatars/fubo_exercise_5.png',
                          width: 65,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          'Hướng dẫn học hiệu quả',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kPrimaryColor),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: InkWell(
                  onTap: () => controller
                      .openUrl('https://www.fkids.edu.vn/cauhoithuonggap'),
                  child: BoxBorderGradient(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/avatars/fubo_exercise_6.png',
                          width: 65,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          'Những câu hỏi thường gặp',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: kPrimaryColor),
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
