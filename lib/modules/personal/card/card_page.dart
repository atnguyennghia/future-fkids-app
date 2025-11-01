import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/services/setting_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'card_controller.dart';

class CardPage extends StatelessWidget {
  final controller = Get.put(CardController());

  CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Thẻ và kích hoạt thẻ',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 890),
          child: ListView(
            children: [
              SettingService.to.isShowActiveCard
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Kích hoạt thẻ mới',
                            style: CustomTheme.semiBold(16),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: KTextField(
                              controller: controller.txtCardNumber,
                              focusNode: controller.txtCardNumberFocusNode,
                              hintText: 'Nhập mã thẻ',
                              textAlign: TextAlign.center,
                            )),
                            KButton(
                              onTap: () => controller.onActive(),
                              title: 'Kích hoạt',
                              height: 40,
                              width: 98,
                              style: CustomTheme.semiBold(14)
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 16,
                            )
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 32, bottom: 16),
                child: Text(
                  'Thẻ đang có hiệu lực',
                  style: CustomTheme.semiBold(16),
                ),
              ),
              SizedBox(
                height: 150,
                child: Obx(() => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BoxBorderGradient(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          width: 275,
                          height: 150,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tài khoản: ${controller.listCardActive[index].email}',
                                      style: CustomTheme.semiBold(12)
                                          .copyWith(color: kAccentColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Ngày kích hoạt: ${controller.listCardActive[index].activeAt}',
                                      style: CustomTheme.semiBold(12)
                                          .copyWith(color: kAccentColor),
                                    ),
                                    Text(
                                      'Mã thẻ: ${controller.listCardActive[index].code}',
                                      style: CustomTheme.semiBold(12)
                                          .copyWith(color: kAccentColor),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${controller.listCardActive[index].cardName}'
                                          .toUpperCase(),
                                      style: CustomTheme.semiBold(20).copyWith(
                                        color: kPrimaryColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${controller.listCardActive[index].cardType}',
                                      style: CustomTheme.regular(14)
                                          .copyWith(color: kNeutral2Color),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Ngày hết hạn',
                                    style: CustomTheme.regular(10)
                                        .copyWith(color: kNeutral2Color),
                                  ),
                                  Text(
                                    '${controller.listCardActive[index].expireAt}',
                                    style: CustomTheme.regular(10)
                                        .copyWith(color: kNeutral2Color),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    width: 53,
                                    height: 35,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: controller.listCardActive.length)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 32, bottom: 16),
                child: Text(
                  'Thẻ hết hạn',
                  style: CustomTheme.semiBold(16),
                ),
              ),
              SizedBox(
                height: 42,
                child: Obx(() => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BoxBorderGradient(
                          padding: const EdgeInsets.all(8),
                          width: 128,
                          height: 42,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.4),
                          child: Center(
                            child: Text(
                              '${controller.listCardExpire[index].code}',
                              style: CustomTheme.medium(12).copyWith(
                                color: kNeutral2Color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                    itemCount: controller.listCardExpire.length)),
              ),
              GetPlatform.isIOS
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Bạn chưa có mã thẻ?',
                            style: CustomTheme.medium(16)
                                .copyWith(color: kNeutral2Color),
                          ),
                        ),
                        KButton(
                          onTap: () => Get.toNamed('/personal/card/iap'),
                          title: 'MUA NGAY',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: Colors.white),
                          width: 328,
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
