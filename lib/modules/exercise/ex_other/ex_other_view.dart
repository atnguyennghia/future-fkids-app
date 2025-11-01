import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../Utils/color_palette.dart';
import '../arrange/arrange_view.dart';
import '../select/select_view.dart';
import '../speaking/speaking_view.dart';
import '../typing/typing_view.dart';
import 'ex_other_controller.dart';

class ExOtherView extends StatelessWidget {
  final controller = Get.put(ExOtherController());

  ExOtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.responsive(mobile: 0, desktop: 32),
        ),
        SizedBox(
          height: 48,
          child: ScrollablePositionedList.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemScrollController: controller.indicatorController,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.exController.listQuestion.length,
            itemBuilder: (context, index) => Obx(() => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedIndex.value == index
                          ? kAccentColor
                          : null),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: CustomTheme.semiBold(
                              context.responsive(mobile: 16, desktop: 24))
                          .copyWith(
                              color: controller.selectedIndex.value == index
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                )),
          ),
        ),
        Expanded(
            child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(controller.exController.listQuestion.length,
              (index) {
            switch (controller.exController.listQuestion[index].type) {
              case "1":
                return SelectView(
                  model: controller.exController.listQuestion[index],
                );
              case "2":
                return ArrangeView(
                  model: controller.exController.listQuestion[index],
                );
              case "3":
                return SpeakingView(
                  model: controller.exController.listQuestion[index],
                );
              case "4":
                return TypingView(
                  model: controller.exController.listQuestion[index],
                );
              default:
                return const SizedBox();
            }
          }),
        )),
      ],
    );
  }
}
