import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/helper.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class BoxItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Function()? onTap;
  final dynamic rank;
  final dynamic reward;
  final dynamic score;
  const BoxItem(
      {Key? key,
      required this.title,
      required this.titleColor,
      this.onTap,
      this.rank,
      this.reward,
      this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: BoxBorderGradient(
            width: 100,
            height: 100,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.2))
            ],
            child: rank != null
                ? getRank()
                : reward != null
                    ? getReward()
                    : getScore(),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: CustomTheme.medium(16).copyWith(
            color: titleColor,
          ),
        )
      ],
    );
  }

  Widget getRank() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/rank_${rank ?? 0}.png',
              height: 56,
            ),
            Text(
              Helper().getNameOfRank(rank ?? 0),
              style: CustomTheme.semiBold(16).copyWith(color: kPrimaryColor),
            )
          ],
        ),
        Positioned(
          child: SvgPicture.asset('assets/icons/info.svg'),
          right: 4,
          top: 4,
        )
      ],
    );
  }

  Widget getReward() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          'assets/icons/diamond.png',
          width: 56,
        ),
        Text(
          NumberFormat.decimalPattern('vi').format(reward ?? 0),
          style: CustomTheme.semiBold(16).copyWith(color: kPrimaryColor),
        )
      ],
    );
  }

  Widget getScore() {
    return Center(
        child: Text(
      NumberFormat('###,###', 'vi').format(score ?? 0),
      style: CustomTheme.semiBold(16).copyWith(color: kPrimaryColor),
    ));
  }
}
