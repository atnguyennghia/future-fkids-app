import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/data/models/profile_rank.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoxRankList extends StatelessWidget {
  final RxList<ProfileRankDetail> listRank;

  const BoxRankList({Key? key, required this.listRank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kAccentColor,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(
                  'Top',
                  style: CustomTheme.medium(14).copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Họ và tên',
                    style: CustomTheme.medium(14).copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Center(
                  child: Text(
                    'Quà tặng',
                    style: CustomTheme.medium(14).copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Tổng điểm',
                    style: CustomTheme.medium(14).copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.white,
          child: Obx(() => ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
              itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    height: 48,
                    color: index == 0
                        ? const Color(0xFFFFD9DA)
                        : index == 1
                            ? const Color(0xFFFFF1CE)
                            : index == 2
                                ? const Color(0xFFD6F0FF)
                                : Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${listRank[index].places}',
                            style: CustomTheme.medium(16)
                                .copyWith(color: kNeutral2Color),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            BoxBorderGradient(
                              boxShape: BoxShape.circle,
                              child: CircleAvatar(
                                backgroundImage:
                                    listRank[index].profileAvatar == null
                                        ? null
                                        : NetworkImage(
                                            '${listRank[index].profileAvatar}'),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Text(
                              '${listRank[index].profileName}',
                              style: CustomTheme.semiBold(14),
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        )),
                        SizedBox(
                          width: 72,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: index < 3,
                                  child: Image.asset(
                                    'assets/icons/top${index + 1}.png',
                                    width: 27,
                                    height: 41,
                                  )),
                              Visibility(
                                  visible: index < 3,
                                  child: Text(
                                    '+',
                                    style: CustomTheme.semiBold(16)
                                        .copyWith(color: kNeutral2Color),
                                  )),
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
                                  Text(
                                    '${listRank[index].places == 1 ? '20' : listRank[index].places == 2 ? '15' : 10}',
                                    style: CustomTheme.semiBold(12)
                                        .copyWith(color: kNeutral2Color),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 72,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              NumberFormat.decimalPattern('vi').format(
                                  (listRank[index].totalPoint ?? 0).round()),
                              style: CustomTheme.semiBold(12),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              itemCount: listRank.length)),
        ))
      ],
    );
  }
}
