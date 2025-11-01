import 'package:futurekids/modules/personal/widgets/personal_appbar.dart';
import 'package:futurekids/widgets/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rule_controller.dart';

class RulePage extends StatelessWidget {
  final controller = Get.put(RuleController());

  RulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: const PersonalAppbar(title: 'Điều khoản',),
      background: Background.personal,
      isShowNavigation: false,
      body: Container(),
    );
  }
}
