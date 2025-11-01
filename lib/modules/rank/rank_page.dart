import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rank_controller.dart';

class RankPage extends StatelessWidget {
  final controller = Get.put(RankController());

  RankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      background: Background.rank,
      route: '/rank',
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            'Bảng xếp hạng',
            style: CustomTheme.semiBold(16).copyWith(color: Colors.black),
          ),
          centerTitle: true,
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
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: context.responsive(mobile: 16, desktop: 32),
                ),
                StrokeText(
                  text: 'Hãy chọn môn để xem bảng xếp hạng',
                  fontSize: context.responsive(mobile: 18, desktop: 24),
                ),
                SizedBox(
                  height: context.responsive(mobile: 16, desktop: 32),
                ),
                context.responsive(
                    mobile: Column(
                      children: _listItem(),
                    ),
                    desktop: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _listItem(isDesktop: true),
                    )),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _listItem({bool isDesktop = false}) {
    return [
      GestureDetector(
        onTap: () => AuthService.to.profileModel.value.typeAccount == 0
            ? controller.showPopupSelectClass(subjectId: 1)
            : Get.toNamed('/rank/detail', arguments: {
                "class_id": AuthService.to.profileModel.value.grade,
                "class_name": AuthService.to.profileModel.value.className,
                "subject_id": 1
              }),
        child: BoxBorderGradient(
          width: isDesktop ? 280 : 290,
          borderRadius: BorderRadius.circular(20),
          borderSize: 5,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(0, 2),
                blurRadius: 4)
          ],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
            child: Image.asset(
                'assets/images/avatar_toan${isDesktop ? '-desktop' : ''}.png'),
          ),
        ),
      ),
      isDesktop
          ? const SizedBox(
              width: 50,
            )
          : const SizedBox(
              height: 16,
            ),
      GestureDetector(
        onTap: () => AuthService.to.profileModel.value.typeAccount == 0
            ? controller.showPopupSelectClass(subjectId: 2)
            : Get.toNamed('/rank/detail', arguments: {
                "class_id": AuthService.to.profileModel.value.grade,
                "class_name": AuthService.to.profileModel.value.className,
                "subject_id": 2
              }),
        child: BoxBorderGradient(
          width: isDesktop ? 280 : 290,
          borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
          borderSize: 5,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(0, 2),
                blurRadius: 4)
          ],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
                'assets/images/avatar_tieng_viet${isDesktop ? '-desktop' : ''}.png'),
          ),
        ),
      ),
      isDesktop
          ? const SizedBox(
              width: 50,
            )
          : const SizedBox(
              height: 16,
            ),
      GestureDetector(
        onTap: () => AuthService.to.profileModel.value.typeAccount == 0
            ? controller.showPopupSelectClass(subjectId: 3)
            : Get.toNamed('/rank/detail', arguments: {
                "class_id": AuthService.to.profileModel.value.grade,
                "class_name": AuthService.to.profileModel.value.className,
                "subject_id": 3
              }),
        child: BoxBorderGradient(
          width: isDesktop ? 280 : 290,
          borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
          borderSize: 5,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(0, 2),
                blurRadius: 4)
          ],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
                'assets/images/avatar_tieng_anh${isDesktop ? '-desktop' : ''}.png'),
          ),
        ),
      ),
    ];
  }
}
