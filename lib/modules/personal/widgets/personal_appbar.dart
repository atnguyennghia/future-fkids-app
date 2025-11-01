import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PersonalAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Image.asset('assets/icons/button_back_ex.png'),
      ),
      title: Text(
        title,
        style: CustomTheme.semiBold(18).copyWith(color: Colors.black),
      ),
      centerTitle: context.responsive(mobile: false, desktop: true),
      backgroundColor: Colors.white.withOpacity(0.4),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: BoxBorderGradient(
          gradientType: GradientType.type2,
          borderSize: 1,
        ),
      ),
    );
  }
}
