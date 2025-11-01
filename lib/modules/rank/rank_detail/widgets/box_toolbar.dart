import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/rank/rank_detail/rank_detail_controller.dart';
import 'package:futurekids/modules/rank/rank_detail/widgets/switch_time.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoxToolbar extends StatelessWidget {
  final controller = Get.find<RankDetailController>();

  BoxToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Container(
              height: 32,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                      onTap: () => controller.previousScope(),
                      child: const Icon(
                        Icons.navigate_before,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${controller.isWeek.value ? 'Tuần' : 'Tháng'} ${controller.isWeek.value ? controller.activeWeek.value.weekNumber : controller.activeMonth.value.month}',
                                style: CustomTheme.medium(14)
                                    .copyWith(color: kPrimaryColor),
                              ),
                              Text(
                                '${DateFormat('dd/MM').format(controller.isWeek.value ? controller.activeWeek.value.days.first : controller.activeMonth.value)}-${DateFormat('dd/MM/yyyy').format(controller.isWeek.value ? controller.activeWeek.value.days.last : DateTime(controller.activeMonth.value.year, controller.activeMonth.value.month + 1, 0))}',
                                style: CustomTheme.semiBold(10)
                                    .copyWith(color: kPrimaryColor),
                              )
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () => controller.nextScope(),
                      child: const Icon(
                        Icons.navigate_next,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(child: SwitchTime()),
          Positioned(
              right: 0,
              child: KButton(
                onTap: () => controller.onRuleClick(),
                width: 95,
                height: 32,
                title: 'Quy luật',
                style: CustomTheme.semiBold(14).copyWith(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
