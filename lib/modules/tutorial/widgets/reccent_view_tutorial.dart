import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../Utils/color_palette.dart';
import '../../../widgets/box_border_gradient.dart';
import '../../../widgets/stroke_text.dart';

class RecentViewTutorial extends StatelessWidget {
  const RecentViewTutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 777),
            child: Row(
              children: [
                Container(
                  width: 23.45,
                  height: context.responsive(mobile: 114, desktop: 185),
                  color: Colors.transparent,
                ),
                Expanded(
                    child: Container(
                  height: context.responsive(mobile: 114, desktop: 185),
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                      top: context.responsive(mobile: 6.83, desktop: 16)),
                  child: BoxBorderGradient(
                    borderSize: 3,
                    borderRadius: BorderRadius.circular(12),
                    gradientType: GradientType.type4,
                    color: Colors.white.withOpacity(0.6),
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                          left: context.responsive(mobile: 56, desktop: 128),
                          right: 8,
                          top: context.responsive(mobile: 8, desktop: 20),
                          bottom: context.responsive(mobile: 2, desktop: 8)),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) => InkWell(
                        child: BoxBorderGradient(
                          borderRadius: BorderRadius.circular(
                              context.responsive(mobile: 12, desktop: 16)),
                          width: context.responsive(mobile: 112, desktop: 172),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/avatar_tutorial_$index.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/fubo_nhun_nguoi.gif',
                height: context.responsive(mobile: 114, desktop: 185),
              )),
          Positioned(
              left: context.responsive(mobile: 80, desktop: 120),
              top: -4,
              child: StrokeText(
                text: 'Bạn đang học',
                color: kAccentColor,
                fontSize: context.responsive(mobile: 16, desktop: 32),
                strokeWidth: 4,
              ))
        ],
      ),
    );
  }
}
