import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final double? radius;
  final TextAlign textAlign;
  final Function()? onTap;
  final List<TextInputFormatter>? listTextInputFormatter;
  final TextInputType? textInputType;

  const KTextField(
      {Key? key,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.obscureText = false,
      this.focusNode,
      this.controller,
      this.radius = 24,
      this.textAlign = TextAlign.start,
      this.onTap,
      this.listTextInputFormatter,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Theme(
          data: ThemeData(
            primarySwatch: kPrimaryMaterialColor,
            hintColor: kNeutral3Color,
          ),
          child: TextField(
            inputFormatters: listTextInputFormatter,
            keyboardType: textInputType,
            onTap: onTap,
            readOnly: onTap != null,
            controller: controller,
            focusNode: focusNode,
            style: CustomTheme.semiBold(16).copyWith(fontFamily: 'Quicksand'),
            obscureText: obscureText,
            // textAlignVertical: TextAlignVertical.center,
            textAlign: textAlign,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius!)),
              ),
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(16),
              isCollapsed: true,
            ),
          )),
    );
  }
}
