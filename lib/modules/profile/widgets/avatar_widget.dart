import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final String? avatarUrl;

  const AvatarWidget(
      {Key? key, required this.title, this.onTap, this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: BoxBorderGradient(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF049FF9),
                        Color(0xFF1B51BA),
                      ]),
                  image: avatarUrl != null
                      ? DecorationImage(
                          image: NetworkImage(avatarUrl!), fit: BoxFit.cover)
                      : null),
              child: avatarUrl == null
                  ? const Icon(
                      CupertinoIcons.plus,
                      size: 32,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 90,
          height: 36,
          child: Text(
            title,
            style: CustomTheme.semiBold(15).copyWith(
              color: kNeutral3Color,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
