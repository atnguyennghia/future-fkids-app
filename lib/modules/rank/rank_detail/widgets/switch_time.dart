import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/rank/rank_detail/rank_detail_controller.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchTime extends StatelessWidget {
  final controller = Get.find<RankDetailController>();

  SwitchTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isWeek.value
        ? Stack(
            children: [
              KButton(
                width: 95,
                height: 32,
                title: ' Tuần',
                titleAlignment: MainAxisAlignment.start,
                style: CustomTheme.semiBold(14).copyWith(color: Colors.white),
              ),
              Positioned(
                  right: 0,
                  width: 95 / 2,
                  height: 32,
                  child: InkWell(
                    onTap: () {
                      controller.isWeek.value = false;
                      if (!controller.hasLoadMonth) {
                        controller.fetchProfileRank(page: 1);
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kNeutral3Color,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24))),
                      child: Center(
                        child: Text('Tháng',
                            style: CustomTheme.semiBold(14)
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ))
            ],
          )
        : Stack(
            children: [
              KButton(
                width: 95,
                height: 32,
                title: 'Tháng',
                titleAlignment: MainAxisAlignment.end,
                style: CustomTheme.semiBold(14).copyWith(color: Colors.white),
              ),
              Positioned(
                  left: 0,
                  width: 95 / 2,
                  height: 32,
                  child: InkWell(
                    onTap: () {
                      controller.isWeek.value = true;
                      if (!controller.hasLoadWeek) {
                        controller.fetchProfileRank(page: 1);
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kNeutral3Color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24))),
                      child: Center(
                        child: Text(' Tuần',
                            style: CustomTheme.semiBold(14)
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                  ))
            ],
          ));
  }
}
