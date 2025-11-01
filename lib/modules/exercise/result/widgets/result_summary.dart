import 'package:futurekids/modules/exercise/result/result_controller.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResultSummary extends StatelessWidget {
  final controller = Get.find<ResultController>();

  ResultSummary({Key? key}) : super(key: key);

  final selectedIndex = 0.obs;

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: Obx(() => IndexedStack(
                index: selectedIndex.value,
                children: [
                  _buildSummary(context),
                  _buildAlert(context),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: context.responsive(mobile: 1, desktop: 1.5),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: SvgPicture.asset(
                      'assets/backgrounds/bg_rank.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      top: 0,
                      child:
                          SvgPicture.asset('assets/backgrounds/phao_hoa.svg')),
                  Positioned(
                      left: -100,
                      child:
                          SvgPicture.asset('assets/backgrounds/phao_hoa.svg')),
                  Positioned(
                      right: -100,
                      child:
                          SvgPicture.asset('assets/backgrounds/phao_hoa.svg')),
                  Positioned(
                      bottom: -100,
                      child:
                          SvgPicture.asset('assets/backgrounds/phao_hoa.svg')),
                  const SizedBox(
                    width: kWidthMobile,
                    height: 436,
                  )
                ],
              ),
            ),
            Transform.scale(
              scale: context.responsive(mobile: 1, desktop: 1.5),
              child: Container(
                width: 341,
                height: 264,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/backgrounds/summary.png'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 88,
                      ),
                      Container(
                        width: 184,
                        height: 48,
                        decoration: BoxDecoration(
                            color: const Color(0xFF440005),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            '+${controller.score.round()} điểm',
                            style: CustomTheme.semiBold(32)
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Số câu đúng:',
                            style: CustomTheme.medium(16).copyWith(
                              color: const Color(0xFF440005),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${controller.numberOfCorrect}/${controller.totalQuestion}',
                            style: CustomTheme.semiBold(18).copyWith(
                              color: const Color(0xFF440005),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Điểm cao nhất:',
                            style: CustomTheme.medium(16).copyWith(
                              color: const Color(0xFF440005),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${controller.highestScore.round()}',
                            style: CustomTheme.semiBold(18).copyWith(
                              color: const Color(0xFF440005),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const Spacer(),
        Transform.scale(
          scale: context.responsive(mobile: 1.0, desktop: 1.5),
          child: Image.asset(
            'assets/avatars/fubo_summary_1.png',
            height: 180,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => selectedIndex.value = 1,
              child: Container(
                width: 96,
                height: 34,
                padding: const EdgeInsets.only(left: 32, top: 6),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/backgrounds/button_left.png'),
                        fit: BoxFit.fill)),
                child: Text(
                  'Học lại',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.nextExercise == null
                  ? Get.back()
                  : Get.offAndToNamed('/exercise', arguments: {
                      "exercise": controller.nextExercise,
                      "category": controller.category
                    }),
              child: Container(
                width: 96,
                height: 34,
                padding: const EdgeInsets.only(left: 8, top: 6),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/backgrounds/button_right.png'),
                        fit: BoxFit.fill)),
                child: Text(
                  'Học tiếp',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAlert(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Transform.scale(
          scale: context.responsive(mobile: 1, desktop: 1.5),
          child: Center(
            child: Container(
              width: 341,
              height: 164,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/backgrounds/summary_alert.png'),
                      fit: BoxFit.fill)),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StrokeText(
                      text:
                          'Nếu bạn nhấn “Học lại” thì\nmọi tiến trình của bài tập này sẽ bị mất.\nBạn có muốn tiếp tục không? ',
                      fontSize: 16,
                      color: const Color(0xFF440005),
                      borderColor: Colors.white.withOpacity(0.25),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => selectedIndex.value = 0,
                          child: Container(
                            width: 82,
                            height: 30,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/backgrounds/summary_alert_no.png'),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: Text(
                                'Không',
                                style: CustomTheme.semiBold(16)
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.offAndToNamed('/exercise',
                              arguments: {
                                "exercise": controller.exercise,
                                "category": controller.category
                              }),
                          child: Container(
                            width: 82,
                            height: 30,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/backgrounds/summary_alert_yes.png'),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: Text(
                                'Có',
                                style: CustomTheme.semiBold(16)
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
        Transform.scale(
          scale: context.responsive(mobile: 1.0, desktop: 1.5),
          child: Image.asset(
            'assets/avatars/fubo_summary_1.png',
            height: 180,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
