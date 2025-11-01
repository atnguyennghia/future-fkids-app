import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseScaffold extends StatelessWidget {
  final Widget body;
  final dynamic subjectId;
  final Widget? title;

  const CourseScaffold(
      {Key? key, required this.body, required this.subjectId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      background: 'subject_$subjectId',
      body: Row(
        children: [
          // constraints.maxWidth >= kWidthDesktop ? const SidebarNavigation(route: '/') : const SizedBox(),
          Expanded(
              child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Image.asset('assets/icons/button_back_$subjectId.png'),
              ),
              titleSpacing: 0.0,
              title: title,
              centerTitle: false,
              backgroundColor: subjectId == 1
                  ? kAccentColor.withOpacity(0.4)
                  : subjectId == 2
                      ? kNeutral2Color.withOpacity(0.5)
                      : kAccentColor.withOpacity(0.4),
              elevation: 0.0,
              automaticallyImplyLeading: false,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: BoxBorderGradient(
                  gradientType: GradientType.type1,
                  borderSize: 1,
                ),
              ),
            ),
            body: body,
          ))
        ],
      ),
    );
  }
}
