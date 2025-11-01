import 'package:futurekids/modules/tutorial/widgets/sidebar_navigation_item_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SidebarNavigationTutorial extends StatelessWidget {
  final String route;

  final int pointerPosition;

  const SidebarNavigationTutorial(
      {Key? key, required this.route, required this.pointerPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
        opacity: 0.25,
        color: Colors.black,
        offset: const Offset(0, 4),
        sigma: 4,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipPath(
              clipper: CustomClipPath(
                  activeIndex: route == '/'
                      ? 0
                      : route == '/achievement'
                          ? 1
                          : route == '/rank'
                              ? 2
                              : 3),
              child: Container(
                width: 273,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 112,
                  child: Image.asset(
                    'assets/images/logo1.png',
                    height: 64,
                    width: 120,
                  ),
                ),
                SizedBox(
                  height: 16 + (route == '/' ? 16 : 0),
                ),
                SidebarNavigationItemTutorial(
                  isActive: route == '/',
                  assetActiveName: 'trang_chu.gif',
                  assetName: 'trang_chu.png',
                  title: 'Trang chủ',
                  onTap: () => route == '/achievement'
                      ? Get.offAndToNamed('/')
                      : Get.toNamed('/'),
                ),
                SidebarNavigationItemTutorial(
                  isActive: route == '/achievement',
                  assetActiveName: 'thanh_tich.gif',
                  assetName: 'thanh_tich.png',
                  title: 'Thành tích',
                  onTap: () => Get.toNamed('/achievement'),
                  showPointer: pointerPosition == 1,
                ),
                SidebarNavigationItemTutorial(
                  isActive: route == '/rank',
                  assetActiveName: 'xep_hang.gif',
                  assetName: 'xep_hang.png',
                  title: 'Xếp hạng',
                  onTap: () => route == '/achievement'
                      ? Get.offAndToNamed('/rank')
                      : Get.toNamed('/rank'),
                  showPointer: pointerPosition == 2,
                ),
                SidebarNavigationItemTutorial(
                  isActive: route == '/personal',
                  assetActiveName: 'ca_nhan.gif',
                  assetName: 'ca_nhan.png',
                  title: 'Cá nhân',
                  onTap: () => route == '/achievement'
                      ? Get.offAndToNamed('/personal')
                      : Get.toNamed('/personal'),
                  showPointer: pointerPosition == 3,
                )
              ],
            )
          ],
        ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  final int activeIndex;
  CustomClipPath({required this.activeIndex});
  @override
  Path getClip(Size size) {
    int headerHeight = 112 + 32;
    double x = size.width;
    double y = size.height;
    final path = Path();

    path.lineTo(0, y);

    path.lineTo(x, y);
    path.quadraticBezierTo(x - 24, y, x - 24, y - 24);

    ///active
    path.lineTo(x - 24, headerHeight + 80 + (activeIndex * 112) + 24);
    path.quadraticBezierTo(x - 24, headerHeight + 80 + (activeIndex * 112),
        x - 24 - 24, headerHeight + 80 + (activeIndex * 112));

    path.lineTo(32 + 24, headerHeight + 80 + (activeIndex * 112));
    path.quadraticBezierTo(32, headerHeight + 80 + (activeIndex * 112), 32,
        headerHeight + 80 + (activeIndex * 112) - 24);

    path.lineTo(32, headerHeight + 24 + (activeIndex * 112));
    path.quadraticBezierTo(32, headerHeight + (activeIndex * 112), 32 + 24,
        headerHeight + (activeIndex * 112));

    path.lineTo(x - 24 - 24, headerHeight + (activeIndex * 112));
    path.quadraticBezierTo(x - 24, headerHeight + (activeIndex * 112), x - 24,
        headerHeight - 24 + (activeIndex * 112));

    ///end active

    path.lineTo(x - 24, 24);
    path.quadraticBezierTo(x - 24, 0, x, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
