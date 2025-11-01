import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BoxBorderGradient extends StatelessWidget {

  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final double borderSize;
  final GradientType gradientType;
  final BoxShape boxShape;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxConstraints? constraints;

  const BoxBorderGradient({
    Key? key, this.child,
    this.borderRadius,
    this.borderSize = 2.0,
    this.gradientType = GradientType.type1,
    this.boxShape = BoxShape.rectangle,
    this.color,
    this.padding,
    this.width,
    this.height,
    this.boxShadow,
    this.constraints
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LinearGradient _borderGradient;
    switch (gradientType){
      case GradientType.type1:
        _borderGradient = LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              const Color(0xFFFFFFFF),
              const Color(0xFFF5F5F5).withOpacity(0.8479),
              const Color(0xFFEBEBEB).withOpacity(0.7),
              const Color(0xFFFFFFFF).withOpacity(0.5)]
        );
        break;
      case GradientType.type2:
        _borderGradient = const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE4E4E4),
              Color(0xFFFFFAFA),
            ]
        );
        break;
      case GradientType.type3:
        _borderGradient = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFFFFF).withOpacity(0.92),
              const Color(0xFFEBEBEB).withOpacity(0.7),
              const Color(0xFFFFFFFF).withOpacity(0.53),
            ]
        );
        break;
      case GradientType.type4:
        _borderGradient = LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color(0xFFEDEDED).withOpacity(1),
              const Color(0xFFE7E7E7).withOpacity(0.55),
            ]
        );
        break;
      case GradientType.type5:
        _borderGradient = LinearGradient(
            colors: [
              const Color(0xFF999999).withOpacity(0.1),
              const Color(0xFF999999).withOpacity(0.1),
            ]
        );
        break;
      case GradientType.accentGradient:
        _borderGradient = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF049FF9),
              Color(0xFF1B51BA),
            ]
        );
        break;
    }

    return Container(
      constraints: constraints,
      padding: padding, // Border width
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          shape: boxShape,
          borderRadius: borderRadius,
          border: GradientBoxBorder(
            width: borderSize,
            gradient: _borderGradient
          ),
        boxShadow: boxShadow
      ),
      child: child,
    );
  }
}

enum GradientType{
  type1,
  type2,
  type3,
  type4,
  type5,
  accentGradient
}