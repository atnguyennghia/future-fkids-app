import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final dynamic percent;
  final double? width;
  final double? height;

  const ProgressBar(
      {Key? key, required this.percent, this.width = 146, this.height = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgrounds/progress_border.png'),
                  fit: BoxFit.fill)),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percent * 0.01,
            heightFactor: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/backgrounds/progress_bar.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
        ),
        Text(
          '${percent.round()}%',
          style: CustomTheme.semiBold(10).copyWith(color: kNeutral2Color),
        )
      ],
    );
  }
}
