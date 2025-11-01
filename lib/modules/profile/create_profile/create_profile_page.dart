import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'create_profile_controller.dart';

class CreateProfilePage extends StatelessWidget {
  final controller = Get.put(CreateProfileController());

  CreateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Image.asset('assets/icons/button_back_ex.png'),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 503),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          BoxBorderGradient(
                            boxShape: BoxShape.circle,
                            borderSize: 3,
                            gradientType: GradientType.type3,
                            child: Obx(() => CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      Image.memory(controller.avatar.value)
                                          .image,
                                )),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => Get.toNamed(
                                    '/profile/select-avatar',
                                    arguments: {"controller": controller}),
                                child: Container(
                                  width: 29,
                                  height: 29,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: SvgPicture.asset(
                                    'assets/icons/pencil.svg',
                                  ),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                          child: StrokeText(text: 'Thông tin của bé'))
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  KTextField(
                    hintText: 'Họ và tên bé*',
                    controller: controller.txtName,
                    focusNode: controller.txtNameFocusNode,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  KTextField(
                    hintText: 'Lớp học*',
                    onTap: () => controller.loadCategory(
                        listItem: controller.listGrade
                            .map((element) => element.toJson())
                            .toList(),
                        selectedIndex: controller.indexGrade,
                        txtController: controller.txtGrade),
                    controller: controller.txtGrade,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  KTextField(
                    hintText: 'Tuổi*',
                    onTap: () => controller.loadCategory(
                        listItem: controller.listAge,
                        selectedIndex: controller.indexAge,
                        txtController: controller.txtAge),
                    controller: controller.txtAge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  KTextField(
                    hintText: 'Giới tính*',
                    onTap: () => controller.loadCategory(
                        listItem: controller.listGender,
                        selectedIndex: controller.indexGender,
                        txtController: controller.txtGender),
                    controller: controller.txtGender,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(() => Visibility(
                        visible: controller.showButton.value,
                        child: KButton(
                          title: 'Xác nhận',
                          style: CustomTheme.semiBold(16)
                              .copyWith(color: Colors.white),
                          onTap: () => controller.onConfirm(),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
