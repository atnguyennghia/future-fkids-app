import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/extension.dart';
import 'package:futurekids/widgets/base_scaffold.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'select_avatar_controller.dart';

class SelectAvatarPage extends StatelessWidget {
  final controller = Get.put(SelectAvatarController());

  SelectAvatarPage({Key? key}) : super(key: key);

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
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 790),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    BoxBorderGradient(
                      borderSize: 3,
                      boxShape: BoxShape.circle,
                      gradientType: GradientType.type3,
                      child: Obx(() => controller.avatar.value.isNotEmpty
                          ? CircleAvatar(
                              radius:
                                  context.responsive(mobile: 60, desktop: 90),
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  Image.memory(controller.avatar.value).image,
                            )
                          : const CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                        child: StrokeText(
                            text: 'Hãy chọn cho bé\nmột hình đại diện nhé'))
                  ],
                ),
                SizedBox(
                  height: context.responsive(mobile: 16, desktop: 32),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: context.responsive(
                          mobile: 345, desktop: double.infinity)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            controller.avatarCarouselController.nextPage(),
                        child: Icon(
                          Icons.navigate_before,
                          color: kAccentColor,
                          size: context.responsive(mobile: 32, desktop: 64),
                        ),
                      ),
                      Expanded(
                          child: CarouselSlider(
                        carouselController: controller.avatarCarouselController,
                        options: CarouselOptions(
                            height:
                                context.responsive(mobile: 184, desktop: 420),
                            viewportFraction: 1.0),
                        items: [0, 1].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GridView.count(
                                mainAxisSpacing:
                                    context.responsive(mobile: 8, desktop: 60),
                                crossAxisSpacing:
                                    context.responsive(mobile: 8, desktop: 60),
                                crossAxisCount: 3,
                                children: [1, 2, 3, 4, 5, 6].map((j) {
                                  return GestureDetector(
                                    onTap: () => controller.loadFile(
                                        'assets/avatars/${i * 6 + j}.png'),
                                    child: BoxBorderGradient(
                                      borderRadius: BorderRadius.circular(24),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.asset(
                                          'assets/avatars/${i * 6 + j}.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        }).toList(),
                      )),
                      GestureDetector(
                        onTap: () =>
                            controller.avatarCarouselController.nextPage(),
                        child: Icon(
                          Icons.navigate_next,
                          color: kAccentColor,
                          size: context.responsive(mobile: 32, desktop: 64),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.responsive(mobile: 16, desktop: 32),
                ),
                BoxBorderGradient(
                  borderRadius: BorderRadius.circular(12),
                  child: MaterialButton(
                    onPressed: () => controller.onPickImage(),
                    child: Text(
                      'Tải ảnh lên',
                      style:
                          CustomTheme.medium(16).copyWith(color: kPrimaryColor),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    height: 48,
                    minWidth: 300,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                KButton(
                  onTap: () => controller.onConfirm(),
                  title: 'Xác nhận',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
