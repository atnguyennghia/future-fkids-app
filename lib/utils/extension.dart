import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension MyContextExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;

  T responsive<T>({
    T? mobile,
    T? desktop,
  }) {
    var deviceWidth = mediaQuerySize.shortestSide;
    if (GetPlatform.isDesktop) {
      deviceWidth = mediaQuerySize.width;
    }
    if (deviceWidth >= 1440 && desktop != null) {
      return desktop;
    } else {
      return mobile!;
    }
  }
}
