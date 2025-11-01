import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'regulation_controller.dart';

class RegulationPage extends StatelessWidget {
  final controller = Get.put(RegulationController());

  RegulationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() => Text('${controller.regulation['title'] ?? ''}')),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Obx(() => HtmlWidget(controller.regulation['content'] ?? '', renderMode: RenderMode.listView,)),
      )
    );
  }
}
