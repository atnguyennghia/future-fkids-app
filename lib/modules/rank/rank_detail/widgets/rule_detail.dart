import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class RuleDetail extends StatelessWidget {
  final RxString rule;
  final Function()? callback;
  const RuleDetail({Key? key, required this.rule, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Container(
            width: 359,
            height: 350,
            padding:
                const EdgeInsets.only(top: 88, left: 40, right: 40, bottom: 32),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgrounds/rule.png'))),
            child: SingleChildScrollView(
              child: Obx(() => HtmlWidget(
                    rule.value,
                    textStyle: CustomTheme.medium(16),
                  )),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: callback,
            child: BoxBorderGradient(
              boxShape: BoxShape.circle,
              color: Colors.white.withOpacity(0.4),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/icons/close.svg',
                width: 14,
                height: 14,
              ),
            ),
          ),
        )
      ],
    );
  }
}
