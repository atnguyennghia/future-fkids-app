import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAnswer extends StatelessWidget {
  final Function() close;
  final Widget content;
  const DialogAnswer({Key? key, required this.close, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.size.height * .75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: kWidthMobile + 48),
            child: InkWell(
              onTap: close,
              child: Align(
                alignment: Alignment.centerRight,
                child: BoxBorderGradient(
                  padding: const EdgeInsets.all(8),
                  boxShape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.4),
                  child: Image.asset(
                    'assets/icons/close.png',
                    width: 16,
                    height: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xFF22f02a), width: 3)),
                child: content,
              ),
              Positioned(
                  top: -18,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/backgrounds/explain_correct_title.png',
                          width: 206,
                          height: 38,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        'Chọn đáp án',
                        style: CustomTheme.semiBold(18),
                      )
                    ],
                  )),
            ],
          ))
        ],
      ),
    );
  }
}
