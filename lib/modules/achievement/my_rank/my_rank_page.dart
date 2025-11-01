import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:futurekids/utils/helper.dart';
import 'my_rank_controller.dart';

class MyRankPage extends StatelessWidget {
  final controller = Get.put(MyRankController());

  MyRankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(
          'Lộ trình của tôi',
          style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
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
          constraints: const BoxConstraints(maxWidth: kWidthMobile),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Text('Điểm', style: CustomTheme.semiBold(18)),
              ),
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemBuilder: (context, index) => TimelineTile(
                  indicatorStyle: IndicatorStyle(
                      width: 14,
                      height: 14,
                      color: index < controller.currentRank + 1
                          ? kPrimaryColor
                          : Colors.white),
                  beforeLineStyle: LineStyle(
                      color: index < controller.currentRank + 1
                          ? kPrimaryColor
                          : Colors.white),
                  afterLineStyle: LineStyle(
                      color: index < controller.currentRank + 1
                          ? kPrimaryColor
                          : Colors.white),
                  alignment: TimelineAlign.manual,
                  lineXY: 0.3,
                  isFirst: index == 0,
                  isLast: index == controller.ranks.length - 1,
                  startChild: Text(
                    NumberFormat.decimalPattern('vi')
                        .format(controller.ranks[index].minPoint),
                    style: CustomTheme.medium(16).copyWith(
                        color: index == controller.currentRank
                            ? kPrimaryColor
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  endChild: Container(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: index == controller.currentRank
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFFF7277),
                              boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      color: Color.fromRGBO(0, 0, 0, 0.25))
                                ])
                          : null,
                      height: 70,
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Image.asset(
                              'assets/icons/rank_$index.png',
                              color: index < controller.currentRank + 1
                                  ? null
                                  : const Color(0xFF545454).withOpacity(0.7),
                              colorBlendMode: index < controller.currentRank + 1
                                  ? null
                                  : BlendMode.modulate,
                            ),
                          ),
                          Text(
                            Helper().getNameOfRank(index),
                            style: CustomTheme.medium(16).copyWith(
                              color: index == controller.currentRank
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: controller.ranks.length,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
