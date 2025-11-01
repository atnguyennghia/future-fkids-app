import 'package:carousel_slider/carousel_slider.dart';
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/gradient_text.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pronunciation_controller.dart';

class PronunciationView extends StatelessWidget {
  late final PronunciationController controller;

  PronunciationView({Key? key, required CategoryModel category})
      : super(key: key) {
    controller = Get.put(PronunciationController(category: category),
        tag: category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.listVocabulary.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: kAccentColor,
            ),
          )
        : Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                  child: CarouselSlider(
                options: CarouselOptions(
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true),
                items: List.generate(
                    controller.listVocabulary.length,
                    (index) => Builder(
                          builder: (BuildContext context) {
                            return BoxBorderGradient(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          color: controller
                                                      .listVocabulary[index]
                                                      .image !=
                                                  null
                                              ? null
                                              : kAccentColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: controller.listVocabulary[index]
                                                  .image !=
                                              null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                controller.listVocabulary[index]
                                                    .image,
                                                fit: BoxFit.contain,
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    // GestureDetector(
                                    //   onTap: () => controller
                                    //           .listVocabulary[index].isSpeaking
                                    //       ? null
                                    //       : controller.onSpeak(index),
                                    //   child: Image.asset(
                                    //     controller.listVocabulary[index]
                                    //             .isSpeaking
                                    //         ? 'assets/icons/loa.gif'
                                    //         : 'assets/icons/loa.png',
                                    //     width: 40,
                                    //     height: 40,
                                    //   ),
                                    // ),
                                    AudioView(
                                        fromURI: controller
                                            .listVocabulary[index].audio,
                                        tag:
                                            'pronunciation_${controller.category.categoryId}_${controller.listVocabulary[index].id}'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    GradientText(
                                      '${controller.listVocabulary[index].word}',
                                      style: CustomTheme.semiBold(18),
                                      gradient: const LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color(0xFF1B51BA),
                                            Color(0xFF049FF9)
                                          ]),
                                    ),
                                    Text(
                                      '${controller.listVocabulary[index].phonetic}',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        color: kNeutral2Color,
                                      ),
                                    ),
                                    Text(
                                      '${controller.listVocabulary[index].means}',
                                      style: CustomTheme.medium(16),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        height: 46,
                                        decoration: BoxDecoration(
                                            color: kNeutral4Color,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => controller
                                              .listVocabulary[index].isRecording
                                          ? null
                                          : controller.onRecord(index),
                                      child: Image.asset(
                                        controller.listVocabulary[index]
                                                .isRecording
                                            ? 'assets/icons/micro.gif'
                                            : 'assets/icons/micro.png',
                                        width: 86,
                                        height: 86,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ));
                          },
                        )),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: KButton(
                  width: double.infinity,
                  height: 48,
                  title: 'Tiếp theo',
                  style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
                ),
              )
            ],
          ));
  }
}
