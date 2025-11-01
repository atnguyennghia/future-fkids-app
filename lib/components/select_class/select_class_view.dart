import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'select_class_controller.dart';

class SelectClassView extends StatelessWidget {
  final Function(int classId, String className) callback;

  final controller = Get.put(SelectClassController());

  SelectClassView({Key? key, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 104),
            child: Container(
              height: Get.height * 0.6,
              constraints: const BoxConstraints(maxWidth: 513),
              padding: const EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Obx(() => controller.listClass.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              callback(controller.listClass[index].id,
                                  controller.listClass[index].name);
                            },
                            child: BoxBorderGradient(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              color: kAccentColor,
                              borderRadius: BorderRadius.circular(12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 64,
                                    child: Image.asset(
                                      controller.listAvatar[index % 5],
                                      height: 48,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      controller.listClass[index].name,
                                      style: CustomTheme.semiBold(20)
                                          .copyWith(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                      itemCount: controller.listClass.length)),
            ),
          ),
          Positioned(
              child: Image.asset(
            'assets/images/fubo_succeed.gif',
            width: 128,
          ))
        ],
      ),
    );
  }
}
