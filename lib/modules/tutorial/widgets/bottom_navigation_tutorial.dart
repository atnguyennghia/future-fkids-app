import 'package:futurekids/modules/tutorial/widgets/bottom_navigation_item_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationTutorial extends StatelessWidget {
  final int pointerPosition;

  const BottomNavigationTutorial({Key? key, required this.pointerPosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    const BottomNavigationItemTutorial(
                      isActive: true,
                      assetActiveName: 'trang_chu.gif',
                      assetName: 'trang_chu.png',
                      title: 'Trang chủ',
                    ),
                    BottomNavigationItemTutorial(
                      isActive: false,
                      assetActiveName: 'thanh_tich.gif',
                      assetName: 'thanh_tich.png',
                      title: 'Thành tích',
                      showPointer: pointerPosition == 1,
                    ),
                    BottomNavigationItemTutorial(
                      isActive: false,
                      assetActiveName: 'xep_hang.gif',
                      assetName: 'xep_hang.png',
                      title: 'Xếp hạng',
                      showPointer: pointerPosition == 2,
                    ),
                    BottomNavigationItemTutorial(
                      isActive: false,
                      assetActiveName: 'ca_nhan.gif',
                      assetName: 'ca_nhan.png',
                      title: 'Cá nhân',
                      showPointer: pointerPosition == 3,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
