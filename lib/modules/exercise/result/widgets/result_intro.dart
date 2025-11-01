import 'package:futurekids/modules/exercise/result/result_controller.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/custom_theme.dart';

class ResultIntro extends StatelessWidget {
  final controller = Get.find<ResultController>();

  ResultIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/result_intro.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter)),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: context.responsive(mobile: 88, desktop: 88 * 2)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Transform.scale(
                scale: context.responsive(mobile: 1.0, desktop: 1.5),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/backgrounds/phao_hoa.svg'),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/backgrounds/exercise_result_alert.svg',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Chúc mừng!\nBạn đã hoàn thành bài tập này',
                            style: CustomTheme.semiBold(18)
                                .copyWith(color: const Color(0xFF440005)),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: context.responsive(mobile: 1.0, desktop: 2),
                child: Image.asset(
                  'assets/avatars/fubo_summary.png',
                  height: 168,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
