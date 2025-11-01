import 'package:futurekids/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonEdit extends StatelessWidget {
  final Function()? onTap;
  const ButtonEdit({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: kPrimaryColor,
            boxShadow: const [
              BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Color.fromRGBO(0, 0, 0, 0.25))
            ]
        ),
        child: SvgPicture.asset('assets/icons/pencil.svg', width: 16, height: 16,),
      ),
    );
  }
}
