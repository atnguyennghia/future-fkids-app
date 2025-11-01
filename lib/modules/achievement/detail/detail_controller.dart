import 'package:futurekids/data/models/achievement_model.dart';
import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/models/unit_model.dart';
import 'package:futurekids/data/providers/achievement_provider.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final book = (Get.arguments["book"] as BookModel).obs;
  final achievement = Get.arguments["achievement"] as AchievementDetail;
  final listUnit = <UnitModel>[].obs;

  void fetchListUnit() async {
    final provider = AchievementProvider();
    final result = await provider
        .getUnitHistory(profileId: achievement.profileId, bookId: book.value.id)
        .catchError((err) => Notify.error(err));

    if (result != null) {
      listUnit.value = result;
    }
  }

  void onSubjectClick() async {
    final dialog = LoadingDialog();
    dialog.show();

    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListBook(
            classId: achievement.classId, subjectId: achievement.subjectId)
        .catchError((err) {
      dialog.dismiss();
      Notify.error(err);
    });

    if (result != null) {
      dialog.custom(
          dismissable: true,
          loadingWidget: BoxBorderGradient(
            constraints: BoxConstraints(
                maxHeight: Get.height * 0.75, maxWidth: kWidthMobile),
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const StrokeText(
                    text: 'Hãy chọn giáo trình để xem thành tích nhé',
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ...result
                      .map((element) => GestureDetector(
                            onTap: () {
                              dialog.dismiss();
                              book.value = element;
                              fetchListUnit();
                            },
                            child: BoxBorderGradient(
                              padding: const EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Image.network(
                                    element.image,
                                    width: 113,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(
                                        '${element.name}:',
                                        style: CustomTheme.semiBold(16),
                                      ),
                                      Text(
                                        '${element.description}',
                                        style: CustomTheme.semiBold(16),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
          ));

      if (result.isEmpty) {
        dialog.dismiss();
        Notify.warning('Không tìm thấy chương trình học!');
      }
    }
  }

  @override
  void onInit() {
    fetchListUnit();
    // TODO: implement onInit
    super.onInit();
  }
}
