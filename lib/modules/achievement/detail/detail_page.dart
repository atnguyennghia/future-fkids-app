import 'package:futurekids/modules/achievement/widgets/box_item.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'detail_controller.dart';

class DetailPage extends StatelessWidget {
  final controller = Get.put(DetailController());

  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            Text(
              'Chi tiết',
              style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
            ),
            const Spacer(),
            InkWell(
              onTap: () => controller.onSubjectClick(),
              child: BoxBorderGradient(
                borderSize: 1,
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.only(left: 8),
                width: 180,
                color: kPrimaryColor,
                child: Row(
                  children: [
                    Expanded(
                        child: Obx(() => Text(
                              '${controller.book.value.description}',
                              softWrap: true,
                              style: CustomTheme.semiBold(16)
                                  .copyWith(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SvgPicture.asset(
                        'assets/icons/button_down.svg',
                        width: 32,
                        height: 32,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16)
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white.withOpacity(0.4),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset('assets/icons/button_back_ex.png'),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: BoxBorderGradient(
            gradientType: GradientType.type2,
            borderSize: 1,
          ),
        ),
      ),
      isShowNavigation: false,
      background: Background.achievement,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 647),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Thành tích ${controller.achievement.subjectId == 1 ? 'Toán' : controller.achievement.subjectId == 2 ? 'Tiếng Việt' : 'Tiếng Anh'}',
                  style: CustomTheme.semiBold(18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BoxItem(
                    title: 'Hạng',
                    titleColor: kNeutral2Color,
                    rank: controller.achievement.rankId,
                    onTap: () =>
                        Get.toNamed('/achievement/my-rank', arguments: {
                      "ranks": controller.achievement.ranks,
                      "current_rank": controller.achievement.rankId
                    }),
                  ),
                  BoxItem(
                      title: 'Kim cương',
                      reward: controller.achievement.amountDiamond,
                      titleColor: kNeutral2Color),
                  BoxItem(
                      title: 'Tổng điểm',
                      score: controller.achievement.totalPoint,
                      titleColor: kNeutral2Color),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Chi tiết',
                    style: CustomTheme.semiBold(18),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: BoxBorderGradient(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF5FC4FF).withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF5FC4FF).withOpacity(0.5),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12))),
                              child: Text(
                                'Nội dung',
                                style: CustomTheme.semiBold(16),
                              ),
                            )),
                            SizedBox(
                              width: 74,
                              child: Center(
                                child: Text(
                                  'Tiến trình',
                                  style: CustomTheme.semiBold(16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 72,
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12))),
                                child: Center(
                                  child: Text(
                                    'Điểm',
                                    style: CustomTheme.semiBold(16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Obx(() => controller.listUnit.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: kPrimaryColor,
                                  ),
                                )
                              : ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  itemBuilder: (context, index) => Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            '${controller.listUnit[index].name}: ${controller.listUnit[index].description}',
                                            style: CustomTheme.medium(14)
                                                .copyWith(
                                                    color: kNeutral2Color),
                                          )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            width: 74,
                                            child: Center(
                                              child: Text(
                                                  '${controller.listUnit[index].percentComplete.round()} %',
                                                  style: CustomTheme.semiBold(
                                                          14)
                                                      .copyWith(
                                                          color:
                                                              kPrimaryColor)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 72,
                                            child: Center(
                                              child: Text(
                                                  '${NumberFormat('###,###', 'vi').format(controller.listUnit[index].point ?? 0)}/${NumberFormat('###,###', 'vi').format(controller.listUnit[index].totalPoint ?? 0)}',
                                                  style: CustomTheme.semiBold(
                                                          14)
                                                      .copyWith(
                                                          color:
                                                              kPrimaryColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 8,
                                      ),
                                  itemCount: controller.listUnit.length)))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
