import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'recent_controller.dart';

class RecentView extends StatelessWidget {
  final controller = Get.put(RecentController());

  RecentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 777),
            child: Row(
              children: [
                Container(
                  width: 23.45,
                  height: context.responsive(mobile: 114, desktop: 185),
                  color: Colors.transparent,
                ),
                Expanded(
                    child: Container(
                  height: context.responsive(mobile: 114, desktop: 185),
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                      top: context.responsive(mobile: 6.83, desktop: 16)),
                  child: BoxBorderGradient(
                    borderSize: 3,
                    borderRadius: BorderRadius.circular(12),
                    gradientType: GradientType.type4,
                    color: Colors.white.withOpacity(0.6),
                    child: Obx(() => controller.listStudying.isEmpty
                        ? Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Bạn chưa học bài nào?',
                                  style: CustomTheme.semiBold(context
                                          .responsive(mobile: 20, desktop: 32))
                                      .copyWith(color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Hãy bắt đầu học bài nhé!',
                                  style: CustomTheme.semiBold(context
                                          .responsive(mobile: 16, desktop: 28))
                                      .copyWith(color: kPrimaryColor),
                                )
                              ],
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(
                                left: context.responsive(
                                    mobile: 56, desktop: 128),
                                right: 8,
                                top: context.responsive(mobile: 8, desktop: 20),
                                bottom:
                                    context.responsive(mobile: 2, desktop: 8)),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listStudying.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => Get.toNamed('/unit', arguments: {
                                "book": controller.listStudying[index]
                              }),
                              child: BoxBorderGradient(
                                borderRadius: BorderRadius.circular(context
                                    .responsive(mobile: 12, desktop: 16)),
                                width: context.responsive(
                                    mobile: 112, desktop: 172),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    '${controller.listStudying[index].image}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 8,
                            ),
                          )),
                  ),
                ))
              ],
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/fubo_nhun_nguoi.gif',
                height: context.responsive(mobile: 114, desktop: 185),
              )),
          Obx(() => Visibility(
              visible: controller.listStudying.isNotEmpty,
              child: Positioned(
                  left: context.responsive(mobile: 80, desktop: 120),
                  top: -4,
                  child: StrokeText(
                    text: 'Bạn đang học',
                    color: kAccentColor,
                    fontSize: context.responsive(mobile: 16, desktop: 32),
                    strokeWidth: 4,
                  ))))
        ],
      ),
    );
  }
}
