import 'package:futurekids/modules/rank/rank_detail/rank_detail_controller.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/helper.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BoxRankInfo extends StatelessWidget {
  final controller = Get.find<RankDetailController>();
  BoxRankInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/backgrounds/bg_rank.svg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => StrokeText(
                    text:
                        '${controller.subjectId == 1 ? 'TOÁN' : controller.subjectId == 2 ? 'TIẾNG VIỆT' : 'TIẾNG ANH'} ${controller.className}'
                            .toUpperCase())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Obx(() => controller.achievement.value.rankId == 0
                          ? const SizedBox(
                              width: 64,
                            )
                          : Image.asset(
                              'assets/icons/rank_${controller.achievement.value.rankId - 1}.png',
                              width: 64,
                              color: const Color(0xFF545454).withOpacity(0.7),
                              colorBlendMode: BlendMode.dstIn,
                            )),
                    ),
                    InkWell(
                      onTap: () =>
                          Get.toNamed('/achievement/my-rank', arguments: {
                        "ranks": controller.achievement.value.ranks,
                        "current_rank": controller.achievement.value.rankId
                      }),
                      child: Column(
                        children: [
                          Obx(() => Image.asset(
                                'assets/icons/rank_${controller.achievement.value.rankId}.png',
                                width: 128,
                              )),
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 8),
                                child: Obx(() => Text(
                                      Helper().getNameOfRank(
                                          controller.achievement.value.rankId),
                                      style: CustomTheme.semiBold(20)
                                          .copyWith(color: kPrimaryColor),
                                    )),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child:
                                      SvgPicture.asset('assets/icons/info.svg'))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Obx(() => controller.achievement.value.rankId == 16
                          ? const SizedBox(
                              width: 64,
                            )
                          : Image.asset(
                              'assets/icons/rank_${controller.achievement.value.rankId + 1}.png',
                              width: 64,
                              color: const Color(0xFF545454).withOpacity(0.7),
                              colorBlendMode: BlendMode.dstIn,
                            )),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
