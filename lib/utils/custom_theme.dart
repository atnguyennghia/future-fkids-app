import 'package:flutter/material.dart';

class CustomTheme {
  static TextStyle light(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w300, height: 1.25);
  }

  static TextStyle regular(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w400, height: 1.25);
  }

  static TextStyle medium(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w500, height: 1.25);
  }

  static TextStyle semiBold(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w600, height: 1.25);
  }

  static TextStyle bold(double? fontSize) {
    return TextStyle(
        fontSize: fontSize, fontWeight: FontWeight.w700, height: 1.25);
  }
}
