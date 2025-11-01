import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationItem extends StatelessWidget {
  final bool isActive;
  final String assetActiveName;
  final String assetName;
  final String title;
  final Function()? onTap;

  const BottomNavigationItem(
      {Key? key,
      this.isActive = false,
      this.assetActiveName = '',
      this.assetName = '',
      this.title = '',
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/images/eclipse.svg'),
                    Positioned(
                      child: Image.asset(
                        'assets/images/$assetActiveName',
                        width: 36,
                      ),
                      bottom: -4,
                    )
                  ],
                ),
                const SizedBox(
                  width: 4,
                ),
                StrokeText(text: title, fontSize: 16)
              ],
            ),
          ),
          Positioned.fill(
            top: -70,
            child: SvgPicture.asset('assets/images/border.svg'),
          ),
        ],
      );
    }

    if (!isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset(
                      'assets/images/eclipse.svg',
                      color: kAccentColor,
                    ),
                    Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/images/$assetName',
                          width: 28,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 22,
                child: StrokeText(
                  text: title,
                  fontSize: 16,
                  color: kAccentColor,
                ),
              )
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
