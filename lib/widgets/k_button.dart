import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  final Function()? onTap;
  final BackgroundColor? backgroundColor;
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final double? width;
  final double? height;
  final MainAxisAlignment titleAlignment;

  const KButton(
      {Key? key,
      this.onTap,
      this.backgroundColor = BackgroundColor.primary,
      this.title = '',
      this.prefixIcon,
      this.suffixIcon,
      this.style,
      this.width = 160,
      this.height = 52,
      this.titleAlignment = MainAxisAlignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: backgroundColor == BackgroundColor.primary
                ? const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                        Color(0xFFEC1C24),
                        Color(0xFFFF6C73),
                      ])
                : backgroundColor == BackgroundColor.accent
                    ? const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                            Color(0xFF1B51BA),
                            Color(0xFF049FF9),
                          ])
                    : const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.centerLeft,
                        colors: [
                            Color(0xFFADADAD),
                            Color(0xFFDDDDDD),
                          ])),
        child: Center(
          child: Row(
            mainAxisAlignment: titleAlignment,
            children: [
              prefixIcon == null ? const SizedBox() : prefixIcon!,
              Text(
                title!,
                style: style,
              ),
              suffixIcon == null ? const SizedBox() : suffixIcon!
            ],
          ),
        ),
      ),
    );
  }
}

enum BackgroundColor { primary, accent, disable }
