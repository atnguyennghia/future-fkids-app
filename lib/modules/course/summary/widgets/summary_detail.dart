import 'package:futurekids/modules/course/summary/summary_controller.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:futurekids/utils/extension.dart';

class SummaryDetail extends StatelessWidget {
  final controller = Get.find<SummaryController>();

  SummaryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      background: 'section_summary',
      body: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.2),
        body: Center(
          child: Transform.scale(
            scale: context.responsive(mobile: 1.0, desktop: 1.2),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                    'assets/backgrounds/section_summary_board.svg'),
                Positioned(
                    top: 32,
                    child: Text(
                      'Tổng Kết Tiết Học',
                      style: CustomTheme.semiBold(20)
                          .copyWith(color: Colors.white),
                    )),
                Positioned(
                    top: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          controller.listCategory.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  width: 311,
                                  height: 58,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/backgrounds/section_summary_item.png'))),
                                  child: Row(
                                    children: [
                                      Text(
                                          '${controller.listCategory[index].categoryName}:',
                                          style: CustomTheme.semiBold(16)
                                              .copyWith(color: Colors.white)),
                                      const Spacer(),
                                      Container(
                                        width: 58,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/backgrounds/section_summary_item_value.png')),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.listCategory[index].percentComplete.round()}%',
                                            style: CustomTheme.medium(16)
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 58,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/backgrounds/section_summary_item_value.png')),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${controller.listCategory[index].point.round()} đ',
                                            style: CustomTheme.medium(16)
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    )),
                Positioned(
                  bottom: 16,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/backgrounds/section_summary_board_bottom.svg'),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('TỔNG',
                              style: CustomTheme.semiBold(20)
                                  .copyWith(color: Colors.white)),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 46,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/backgrounds/section_summary_value.png'),
                                )),
                                child: Center(
                                  child: Text(
                                    '${controller.averagePercent} %',
                                    style: CustomTheme.semiBold(18)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 100,
                                height: 46,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/backgrounds/section_summary_value.png'),
                                )),
                                child: Center(
                                  child: Text(
                                      '${controller.totalScore.round()} đ',
                                      style: CustomTheme.semiBold(18)
                                          .copyWith(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: KButton(
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
          onTap: () {
            Get.back();
          },
          width: 328,
          title: 'Kết thúc bài học',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
