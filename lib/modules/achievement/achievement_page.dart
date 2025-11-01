import 'package:futurekids/modules/achievement/widgets/box_item.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'achievement_controller.dart';

class AchievementPage extends StatelessWidget {
  final controller = Get.put(AchievementController());

  AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      background: Background.achievement,
      route: '/achievement',
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Obx(() => AuthService.to.profileModel.value.typeAccount == 0
              ? Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Thành tích',
                      style: CustomTheme.semiBold(18)
                          .copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => controller.showPopupSelectClass(),
                      child: BoxBorderGradient(
                        borderSize: 1,
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.only(left: 8),
                        width: 140,
                        color: kPrimaryColor,
                        child: Row(
                          children: [
                            Expanded(
                                child: Obx(() => Text(
                                      '${controller.selectedClassName}',
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
                )
              : Text(
                  'Thành tích',
                  style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
                )),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(0.4),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: BoxBorderGradient(
              gradientType: GradientType.type2,
              borderSize: 1,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Obx(() => Visibility(
                visible: AuthService.to.profileModel.value.typeAccount == 0,
                child: SizedBox(
                  height: 88,
                  child: ListView.separated(
                      padding: const EdgeInsets.only(
                          bottom: 8, left: 16, right: 16, top: 8),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              controller.selectedIndexProfile.value = index;
                              if (AuthService.to.userModel.value.profile?[index]
                                      .typeAccount !=
                                  0) {
                                controller.fetchAchievement(
                                    profileId: AuthService
                                        .to.userModel.value.profile?[index].id,
                                    classId: AuthService.to.userModel.value
                                        .profile?[index].grade);
                              } else {
                                controller.fetchAchievement(
                                    profileId: AuthService
                                        .to.userModel.value.profile?[index].id,
                                    classId: controller.selectedClassId);
                              }
                            },
                            child: Obx(() => BoxBorderGradient(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  width: 209,
                                  height: 80,
                                  borderRadius: BorderRadius.circular(12),
                                  color: index ==
                                          controller.selectedIndexProfile.value
                                      ? kAccentColor
                                      : Colors.white.withOpacity(0.7),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromRGBO(0, 0, 0, 0.2))
                                  ],
                                  child: Row(
                                    children: [
                                      BoxBorderGradient(
                                        boxShape: BoxShape.circle,
                                        child: CircleAvatar(
                                          backgroundImage: AuthService
                                                      .to
                                                      .userModel
                                                      .value
                                                      .profile?[index]
                                                      .avatar ==
                                                  null
                                              ? null
                                              : NetworkImage(
                                                  '${AuthService.to.userModel.value.profile?[index].avatar}'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: index == 0
                                              ? Center(
                                                  child: Text(
                                                    '${AuthService.to.userModel.value.profile?[index].name}',
                                                    style: CustomTheme.semiBold(
                                                            16)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: index ==
                                                                    controller
                                                                        .selectedIndexProfile
                                                                        .value
                                                                ? Colors.white
                                                                : kNeutral2Color),
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${AuthService.to.userModel.value.profile?[index].name}',
                                                      style:
                                                          CustomTheme.semiBold(
                                                                  16)
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: index ==
                                                                controller
                                                                    .selectedIndexProfile
                                                                    .value
                                                            ? Colors.white
                                                            : kNeutral2Color,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '${AuthService.to.userModel.value.profile?[index].age} tuổi',
                                                      style:
                                                          CustomTheme.medium(16)
                                                              .copyWith(
                                                        color: index ==
                                                                controller
                                                                    .selectedIndexProfile
                                                                    .value
                                                            ? Colors.white
                                                            : kNeutral2Color,
                                                      ),
                                                    )
                                                  ],
                                                ))
                                    ],
                                  ),
                                )),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 16,
                          ),
                      itemCount:
                          AuthService.to.userModel.value.profile?.length ?? 0),
                ))),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 623),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: BoxBorderGradient(
                    width: double.infinity,
                    height: 180,
                    borderRadius: BorderRadius.circular(12),
                    color: kAccentColor.withOpacity(0.6),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.2))
                    ],
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const StrokeText(
                          text: 'Thành tích tổng',
                          fontSize: 18,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      '/achievement/my-rank',
                                      arguments: {
                                        'ranks': controller
                                            .achievement.value.total?.ranks,
                                        'current_rank': controller
                                            .achievement.value.total?.rankId
                                      }),
                                  child: BoxItem(
                                    title: 'Hạng',
                                    titleColor: Colors.white,
                                    rank: controller
                                        .achievement.value.total?.rankId,
                                  ),
                                ),
                                BoxItem(
                                    title: 'Kim cương',
                                    titleColor: Colors.white,
                                    reward: controller.achievement.value.total
                                        ?.amountDiamond),
                                BoxItem(
                                    title: 'Tổng điểm',
                                    titleColor: Colors.white,
                                    score: controller
                                        .achievement.value.total?.totalPoint),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 623),
                child: Obx(() => ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thành tích ${controller.achievement.value.statistics[index].subjectId == 1 ? 'Toán' : controller.achievement.value.statistics[index].subjectId == 2 ? 'Tiếng Việt' : 'Tiếng Anh'}',
                                  style: CustomTheme.semiBold(16),
                                ),
                                KButton(
                                  onTap: () => controller.onSubjectClick(
                                      classId: controller.achievement.value
                                          .statistics[index].classId,
                                      subjectId: controller.achievement.value
                                          .statistics[index].subjectId,
                                      achievementDetail: controller
                                          .achievement.value.statistics[index]),
                                  width: 80,
                                  height: 32,
                                  title: 'Chi tiết',
                                  style: CustomTheme.bold(14)
                                      .copyWith(color: Colors.white),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 2),
                                    child: SvgPicture.asset(
                                      'assets/icons/button_next.svg',
                                      color: Colors.white,
                                      height: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () => Get.toNamed(
                                      '/achievement/my-rank',
                                      arguments: {
                                        'ranks': controller.achievement.value
                                            .statistics[index].ranks,
                                        'current_rank': controller.achievement
                                            .value.statistics[index].rankId
                                      }),
                                  child: BoxItem(
                                    title: 'Hạng',
                                    titleColor: kNeutral2Color,
                                    rank: controller.achievement.value
                                        .statistics[index].rankId,
                                  ),
                                ),
                                BoxItem(
                                  title: 'Kim cương',
                                  titleColor: kNeutral2Color,
                                  reward: controller.achievement.value
                                      .statistics[index].amountDiamond,
                                ),
                                BoxItem(
                                    title: 'Tổng điểm',
                                    titleColor: kNeutral2Color,
                                    score: controller.achievement.value
                                        .statistics[index].totalPoint),
                              ],
                            )
                          ],
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: controller.achievement.value.statistics.length)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
