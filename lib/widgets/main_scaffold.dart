import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/bottom_navigation_item.dart';
import 'package:futurekids/widgets/sidebar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final String route;
  final Background background;
  final bool isShowNavigation;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;

  const MainScaffold(
      {Key? key,
      this.appBar,
      required this.body,
      this.route = '/',
      this.background = Background.main,
      this.isShowNavigation = true,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.persistentFooterButtons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String assetPath = '';
    switch (background) {
      case Background.main:
        assetPath = 'main';
        break;
      case Background.achievement:
        assetPath = 'achievement';
        break;
      case Background.rank:
        assetPath = 'rank';
        break;
      case Background.personal:
        assetPath = 'personal';
        break;
    }

    return context.responsive(
        desktop: BaseScaffold(
          background: assetPath,
          appBar: appBar,
          body: Row(
            children: [
              isShowNavigation
                  ? SidebarNavigation(route: route)
                  : const SizedBox(),
              Expanded(child: body)
            ],
          ),
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          persistentFooterButtons: persistentFooterButtons,
        ),
        mobile: BaseScaffold(
          background: assetPath,
          appBar: appBar,
          body: body,
          bottomNavigationBar: isShowNavigation
              ? Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(98, 174, 0, 0.4),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, -2),
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25))
                      ]),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SafeArea(
                          child: SizedBox(
                            height: 70,
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BottomNavigationItem(
                                  isActive: route == '/',
                                  assetActiveName: 'trang_chu.gif',
                                  assetName: 'trang_chu.png',
                                  title: 'Trang chủ',
                                  onTap: () => route == '/achievement'
                                      ? Get.offAndToNamed('/')
                                      : Get.toNamed('/'),
                                ),
                                BottomNavigationItem(
                                  isActive: route == '/achievement',
                                  assetActiveName: 'thanh_tich.gif',
                                  assetName: 'thanh_tich.png',
                                  title: 'Thành tích',
                                  onTap: () => Get.toNamed('/achievement'),
                                ),
                                BottomNavigationItem(
                                  isActive: route == '/rank',
                                  assetActiveName: 'xep_hang.gif',
                                  assetName: 'xep_hang.png',
                                  title: 'Xếp hạng',
                                  onTap: () => route == '/achievement'
                                      ? Get.offAndToNamed('/rank')
                                      : Get.toNamed('/rank'),
                                ),
                                BottomNavigationItem(
                                  isActive: route == '/personal',
                                  assetActiveName: 'ca_nhan.gif',
                                  assetName: 'ca_nhan.png',
                                  title: 'Cá nhân',
                                  onTap: () => route == '/achievement'
                                      ? Get.offAndToNamed('/personal')
                                      : Get.toNamed('/personal'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          persistentFooterButtons: persistentFooterButtons,
        ));
  }
}

enum Background { main, achievement, rank, personal }
