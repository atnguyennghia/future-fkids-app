import 'package:futurekids/modules/home/home_controller.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubjectWidget extends StatelessWidget {
  final HomeController controller;

  const SubjectWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.responsive(
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _listItem(isDesktop: true),
        ),
        mobile: Column(
          children: _listItem(),
        ));
  }

  List<Widget> _listItem({bool isDesktop = false}) {
    return [
      GestureDetector(
        onTap: () => controller.onSubjectClick(
            subjectId: 1, classId: AuthService.to.profileModel.value.grade),
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
                'assets/images/avatar_toan${isDesktop ? '-desktop' : ''}.png'),
          ),
        ),
      ),
      isDesktop ? const SizedBox(width: 50) : const SizedBox(height: 16),
      GestureDetector(
        onTap: () => controller.onSubjectClick(
            subjectId: 2, classId: AuthService.to.profileModel.value.grade),
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
      isDesktop ? const SizedBox(width: 50) : const SizedBox(height: 16),
      GestureDetector(
        onTap: () => controller.onSubjectClick(
            subjectId: 3, classId: AuthService.to.profileModel.value.grade),
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
      )
    ];
  }
}
