import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SummaryIntro extends StatelessWidget {
  const SummaryIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      background: 'section_summary',
      body: Padding(
        padding: EdgeInsets.only(
            bottom: context.responsive(mobile: 88, desktop: 88 * 3)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                          'assets/backgrounds/section_summary_alert.svg',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Chúc mừng!\nBạn đã hoàn thành tiết học này',
                            style: CustomTheme.semiBold(20)
                                .copyWith(color: kPrimaryColor),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Transform.scale(
                scale: context.responsive(mobile: 1.0, desktop: 2),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset('assets/backgrounds/bg_rank.svg'),
                    Image.asset(
                      'assets/avatars/fubo_summary.png',
                      height: 168,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
