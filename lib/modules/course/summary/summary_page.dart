import 'package:futurekids/modules/course/summary/widgets/summary_detail.dart';
import 'package:futurekids/modules/course/summary/widgets/summary_intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'summary_controller.dart';

class SummaryPage extends StatelessWidget {
  final controller = Get.put(SummaryController());

  SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => IndexedStack(
      index: controller.selectedIndex.value,
      children: [
        const SummaryIntro(),
        SummaryDetail()
      ],
    ));
  }
}
