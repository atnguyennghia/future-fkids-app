import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const SizedBox(),
              Positioned(
                top: -54,
                child: Image.asset(
                  'assets/images/fubo.gif',
                  width: context.responsive(mobile: 72, desktop: 96),
                ),
              )
            ],
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const SizedBox(),
              Positioned(
                  top: context.responsive(mobile: 24, desktop: 48),
                  child: Container(
                    width: context.responsive(mobile: 354.73, desktop: 679.35),
                    height: context.responsive(mobile: 106, desktop: 175),
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Bạn chưa có khoá học của riêng mình?',
                            style: CustomTheme.semiBold(
                                    context.responsive(mobile: 16, desktop: 28))
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Đăng ký ngay để FutureKids đồng hành cùng bạn nhé',
                            style: CustomTheme.medium(
                                    context.responsive(mobile: 12, desktop: 20))
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: context.responsive(mobile: 32, desktop: 52),
                          )
                        ],
                      ),
                    ),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/banner.png'),
                            fit: BoxFit.contain)),
                  ))
            ],
          ),
          SizedBox(
            height: context.responsive(mobile: 24, desktop: 48),
          ),
          InkWell(
            onTap: () => Get.toNamed('/auth/register'),
            child: SizedBox(
              width: context.responsive(mobile: 300, desktop: 500),
              height: context.responsive(mobile: 96, desktop: 140),
            ),
          ),
          SizedBox(
            height: context.responsive(mobile: 16, desktop: 48),
          ),
        ],
      ),
    );
  }
}
