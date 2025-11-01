import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'box_border_gradient.dart';

class ButtonClose extends StatelessWidget {
  final Function()? onTap;

  const ButtonClose({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: BoxBorderGradient(
          padding: const EdgeInsets.all(8),
          boxShape: BoxShape.circle,
          gradientType: GradientType.type2,
          color: Colors.white.withOpacity(0.4),
          child: SvgPicture.asset(
            'assets/icons/close.svg',
            width: 16,
            height: 16,
          ),
        ),
      ),
    );
  }
}
