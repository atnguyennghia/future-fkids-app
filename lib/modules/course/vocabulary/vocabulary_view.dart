import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/modules/exercise/components/audio/audio_view.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'vocabulary_controller.dart';

class VocabularyView extends StatelessWidget {
  late final VocabularyController controller;

  VocabularyView({Key? key, required CategoryModel category})
      : super(key: key) {
    controller = Get.put(VocabularyController(category: category),
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
        : ListView.separated(
            padding: const EdgeInsets.only(top: 32, bottom: 8),
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      BoxBorderGradient(
                        padding: EdgeInsets.zero,
                        width: 80,
                        height: 80,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, .25))
                        ],
                        color: controller.listVocabulary[index].image == null
                            ? kAccentColor
                            : Colors.transparent,
                        borderSize: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: controller.listVocabulary[index].image == null
                              ? const SizedBox()
                              : Image.network(
                                  controller.listVocabulary[index].image,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.listVocabulary[index].word}',
                            style: CustomTheme.semiBold(16),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${controller.listVocabulary[index].phonetic}',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: kNeutral2Color,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${controller.listVocabulary[index].means}',
                            style: CustomTheme.medium(16)
                                .copyWith(color: kNeutral2Color),
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      AudioView(
                          fromURI: controller.listVocabulary[index].audio,
                          tag:
                              'vocabulary_${controller.category.categoryId}_${controller.listVocabulary[index].id}')
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => const BoxBorderGradient(
                  height: 1,
                  borderSize: 1,
                ),
            itemCount: controller.listVocabulary.length));
  }
}
