import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/rank/rank_detail/widgets/box_rank_info.dart';
import 'package:futurekids/modules/rank/rank_detail/widgets/box_rank_list.dart';
import 'package:futurekids/modules/rank/rank_detail/widgets/box_toolbar.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'rank_detail_controller.dart';
import 'widgets/profile_rank.dart';

class RankDetailPage extends StatelessWidget {
  final controller = Get.put(RankDetailController());

  RankDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            IconButton(
                onPressed: () => Get.back(),
                icon: Image.asset('assets/icons/button_back_ex.png')),
            Text(
              'Bảng xếp hạng',
              style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
            ),
            const Spacer(),
            Visibility(
                visible: AuthService.to.profileModel.value.typeAccount == 0,
                child: InkWell(
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
                                  '${controller.className}',
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
                )),
            const SizedBox(width: 16)
          ],
        ),
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
      isShowNavigation: false,
      background: Background.rank,
      body: context.responsive(
          mobile: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: kWidthMobile * 1.5),
              child: Column(
                children: [
                  BoxToolbar(),
                  BoxRankInfo(),
                  Expanded(
                      child: Obx(() => IndexedStack(
                            index: controller.isWeek.value ? 0 : 1,
                            children: [
                              BoxRankList(
                                listRank: controller.listRankWeek,
                              ),
                              BoxRankList(
                                listRank: controller.listRankMonth,
                              )
                            ],
                          )))
                ],
              ),
            ),
          ),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: kWidthMobile,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    BoxToolbar(),
                    BoxRankInfo(),
                  ],
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Container(
                padding: const EdgeInsets.only(top: 32),
                constraints: const BoxConstraints(maxWidth: kWidthMobile),
                child: Obx(() => IndexedStack(
                      index: controller.isWeek.value ? 0 : 1,
                      children: [
                        BoxRankList(
                          listRank: controller.listRankWeek,
                        ),
                        BoxRankList(
                          listRank: controller.listRankMonth,
                        )
                      ],
                    )),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: context.responsive(
          mobile: Container(
            constraints: const BoxConstraints(maxWidth: kWidthMobile * 1.5),
            child: _myRank(),
          ),
          desktop: Container(
            constraints: const BoxConstraints(maxWidth: kWidthMobile * 2 + 24),
            child: Row(
              children: [
                const SizedBox(
                  width: kWidthMobile + 24,
                ),
                Expanded(child: _myRank())
              ],
            ),
          )),
    );
  }

  Widget _myRank() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 16),
      height: 60,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF049FF9), Color(0xFF1B51BA)]),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -4),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.15))
          ]),
      child: Obx(() => IndexedStack(
            index: controller.isWeek.value ? 0 : 1,
            children: [
              ProfileRank(
                profileRank: controller.profileRankWeek,
              ),
              ProfileRank(
                profileRank: controller.profileRankMonth,
              )
            ],
          )),
    );
  }
}
