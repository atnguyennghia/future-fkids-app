import 'package:futurekids/utils/color_palette.dart';
import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final double height;
  final dynamic percent;

  const StatusBar({Key? key, required this.height, required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: kNeutral3Color),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percent * 0.01,
        heightFactor: 1.0,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 2),
                color: kAccentColor)),
      ),
    );
  }
}
