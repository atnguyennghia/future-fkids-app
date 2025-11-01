import 'package:futurekids/components/select_class/select_class_view.dart';
import 'package:futurekids/data/models/achievement_model.dart';
import 'package:futurekids/data/providers/achievement_provider.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchievementController extends GetxController {
  final achievement = AchievementModel().obs;
  final selectedIndexProfile = 0.obs;
  dynamic selectedClassId;
  final selectedClassName = ''.obs;

  void showPopupSelectClass() {
    final dialog = LoadingDialog();
    dialog.custom(
        dismissable: false,
        loadingWidget: SelectClassView(
          callback: (classId, className) {
            dialog.dismiss();
            selectedIndexProfile.value = 0;
            selectedClassId = classId;
            selectedClassName.value = className;
            fetchAchievement(
                profileId: AuthService.to.profileModel.value.id,
                classId: classId);
          },
        ));
  }

  void onSubjectClick(
      {dynamic classId,
      dynamic subjectId,
      required AchievementDetail achievementDetail}) async {
    final dialog = LoadingDialog();
    dialog.show();

    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListBook(classId: classId, subjectId: subjectId)
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
                  ...result
                      .map((element) => Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: GestureDetector(
                              onTap: () {
                                dialog.dismiss();
                                Get.toNamed('/achievement/detail', arguments: {
                                  "book": element,
                                  "achievement": achievementDetail
                                });
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

  void fetchAchievement(
      {required dynamic profileId, required dynamic classId}) async {
    final dialog = LoadingDialog();
    dialog.show();

    final provider = AchievementProvider();
    final result = await provider
        .getAchievement(profileId: profileId, classId: classId)
        .catchError((err) {
      dialog.dismiss();
      Notify.error(err);
    });

    if (result != null) {
      dialog.dismiss();
      achievement.value = result;
    }
  }

  void initData() {
    if (AuthService.to.profileModel.value.typeAccount == 0) {
      showPopupSelectClass();
    } else {
      fetchAchievement(
          profileId: AuthService.to.profileModel.value.id,
          classId: AuthService.to.profileModel.value.grade);
    }
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }
}
