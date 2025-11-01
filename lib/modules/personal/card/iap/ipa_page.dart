import 'package:futurekids/modules/personal/card/iap/iap_controller.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/personal_appbar.dart';

class IAPPage extends StatelessWidget {
  final controller = Get.put(IAPController());
  IAPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(
        title: 'Mua mã thẻ mới',
      ),
      background: Background.personal,
      isShowNavigation: false,
      body: Obx(() => controller.listProducts.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => BoxBorderGradient(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.listProducts[index].title.toUpperCase(),
                        style: CustomTheme.semiBold(22)
                            .copyWith(color: kAccentColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Giá ${controller.listProducts[index].rawPrice} ${controller.listProducts[index].currencyCode}',
                                style: CustomTheme.semiBold(20)
                                    .copyWith(color: kPrimaryColor),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                GetUtils.capitalizeFirst(controller
                                        .listProducts[index].description) ??
                                    '',
                                style: CustomTheme.regular(12)
                                    .copyWith(color: kNeutral2Color),
                              )
                            ],
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 45,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      KButton(
                        onTap: () => controller.showConfirm(index),
                        title: 'Thanh toán',
                        width: double.infinity,
                        style: CustomTheme.semiBold(16)
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: controller.listProducts.length,
            )),
    );
  }
}
