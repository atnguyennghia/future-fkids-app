import 'package:futurekids/modules/exercise/result/widgets/result_intro.dart';
import 'package:futurekids/modules/exercise/result/widgets/result_summary.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/button_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'result_controller.dart';

class ResultPage extends StatelessWidget {
  final controller = Get.put(ResultController());

  ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          ButtonClose(
            onTap: () => Get.back(),
          )
        ],
      ),
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              ResultIntro(),
              ResultSummary(),
            ],
          )),
    );
  }
}
