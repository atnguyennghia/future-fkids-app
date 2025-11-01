import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/modules/tutorial/widgets/scale_animation_widget.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarNavigationItemTutorial extends StatelessWidget {
  final bool isActive;
  final String assetActiveName;
  final String assetName;
  final String title;
  final Function()? onTap;
  final bool showPointer;

  const SidebarNavigationItemTutorial({
    Key? key,
    this.isActive = false,
    this.assetActiveName = '',
    this.assetName = '',
    this.title = '',
    this.onTap,
    this.showPointer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return Container(
          width: 217,
          height: title == 'Thành tích' || title == 'Xếp hạng' ? 112 : 96,
          padding: EdgeInsets.only(
              bottom: title == 'Trang chủ' ? 16 : 0,
              top: title == 'Trang chủ' ? 0 : 8),
          child: Row(
            children: [
              const SizedBox(
                width: 32,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: title == 'Xếp hạng' ? 4 : 0,
                    top: title == 'Cá nhân' ? 4 : 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/eclipse.svg',
                      height: 48,
                    ),
                    Positioned(
                      child: Image.asset(
                        'assets/images/$assetActiveName',
                        height: 64,
                      ),
                      bottom: -4,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: title == 'Cá nhân' ? 8 : 0,
                    bottom:
                        title == 'Xếp hạng' || title == 'Thành tích' ? 8 : 0,
                    left: 8),
                child: StrokeText(
                  text: title,
                  fontSize: 20,
                ),
              )
            ],
          ));
    }

    if (!isActive) {
      return GestureDetector(
        onTap: onTap,
        child: SizedBox(
            width: 217,
            height: 112,
            child: Row(
              children: [
                const SizedBox(
                  width: 32,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset(
                      'assets/images/eclipse.svg',
                      color: kAccentColor,
                      height: 48,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            'assets/images/$assetName',
                            height: 64,
                          ),
                          Positioned(
                              top: 32,
                              right: -160,
                              child: Opacity(
                                opacity: showPointer ? 1.0 : 0.0,
                                child: ScaleAnimationWidget(
                                  child: Image.asset(
                                    'assets/images/pointer.png',
                                    width: 52,
                                    height: 39,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 8),
                  child: StrokeText(
                    text: title,
                    color: kAccentColor,
                    fontSize: 20,
                  ),
                )
              ],
            )),
      );
    }

    return const SizedBox();
  }
}
