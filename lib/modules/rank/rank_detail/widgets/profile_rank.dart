import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/data/models/profile_rank.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileRank extends StatelessWidget {
  final Rx<ProfileRankDetail> profileRank;

  const ProfileRank({Key? key, required this.profileRank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Stack(
            children: [
              Positioned.fill(child: SvgPicture.asset('assets/icons/left.svg')),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Obx(() => Text(
                        '${profileRank.value.places ?? '--'}',
                        style: CustomTheme.medium(16)
                            .copyWith(color: kPrimaryColor),
                      )),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
            child: Row(
          children: [
            BoxBorderGradient(
              boxShape: BoxShape.circle,
              child: CircleAvatar(
                backgroundImage: AuthService.to.profileModel.value.avatar ==
                        null
                    ? null
                    : NetworkImage(AuthService.to.profileModel.value.avatar),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              '${AuthService.to.profileModel.value.name}',
              style: CustomTheme.semiBold(14).copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ))
          ],
        )),
        SizedBox(
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Image.asset(
                      'assets/icons/diamond.png',
                      width: 22,
                      height: 18,
                    ),
                  ),
                  Obx(() => Text(
                      profileRank.value.places == null
                          ? '0'
                          : profileRank.value.places == 1
                              ? '20'
                              : profileRank.value.places == 2
                                  ? '15'
                                  : (profileRank.value.places ?? 0) < 101
                                      ? '10'
                                      : '0',
                      style: CustomTheme.semiBold(12)
                          .copyWith(color: Colors.white)))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 60,
          child: Align(
            alignment: Alignment.centerRight,
            child: Obx(() => Text(
                  NumberFormat.decimalPattern('vi')
                      .format(profileRank.value.totalPoint?.round() ?? 0),
                  style: CustomTheme.semiBold(12).copyWith(color: Colors.white),
                )),
          ),
        )
      ],
    );
  }
}
