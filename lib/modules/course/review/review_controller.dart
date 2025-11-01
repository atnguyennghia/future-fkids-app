import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/data/providers/review_provider.dart';
import 'package:futurekids/data/providers/submit_provider.dart';
import 'package:futurekids/modules/course/course_controller.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/auth_service.dart';
import '../../lesson/lesson_controller.dart';
import '../../unit/unit_controller.dart';

class ReviewController extends GetxController {
  final CategoryModel category;
  ReviewController({required this.category});
  final courseController = Get.find<CourseController>();
  final listReview = <dynamic>[].obs;

  final listComment = <dynamic>[].obs;
  final linkVideoOfUser = ''.obs;
  final avatar = ''.obs;

  void fetchComment() async {
    final _provider = ReviewProvider();
    final _result = await _provider
        .getComment(
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            contentId: listReview.first["id"])
        .catchError((err) {
      Notify.error(err);
      printError(info: err);
    });

    if (_result != null && _result.toString() != '[]') {
      linkVideoOfUser.value = _result['driver_file_link'];
      listComment.value = _result['comment'];
      avatar.value = listComment.first['avatar'] ?? '';
    }
  }

  void fetchReview() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getContent(
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            categoryType: 5)
        .catchError((err) => Notify.error(err));
    if (result != null) {
      listReview.value = result["contents"];

      if (AuthService.to.hasLogin) {
        fetchComment();
      }
    }
  }

  void submitData() async {
    if (!AuthService.to.hasLogin) {
      final _dialog = LoadingDialog(dismissAble: true);
      _dialog.show();
      _dialog.succeed(
          message: 'Hãy đăng nhập để sử dụng\nchức năng này bạn nhé!',
          callback: () {
            _dialog.dismiss();
            Get.offAndToNamed('/auth/login');
          },
          title: 'Đăng nhập');
      return;
    }

    final _dialog = LoadingDialog();
    _dialog.show();
    final _provider = SubmitProvider();
    final _result = await _provider
        .submitData(
            profileId: AuthService.to.profileModel.value.id,
            courseId: courseController.course.courseId,
            categoryId: category.categoryId,
            contentId: listReview.first["id"],
            point: listReview.first["point"],
            percentComplete: 100)
        .catchError((err) {
      _dialog.dismiss();
      Notify.error(err);
    });

    if (_result != null && _result) {
      //fetch lại data lesson, unit
      Get.find<LessonController>().fetchLesson();
      Get.find<UnitController>().fetchUnit();

      _dialog.dismiss();
      Get.offAndToNamed('/summary');
    }
  }

  void pickUpVideo() async {
    final ImagePicker _picker = ImagePicker();
    // Pick a video
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      final videoLength = (await video.readAsBytes()).lengthInBytes;
      if (videoLength > 314572800) {
        Notify.error('Video chỉ có dung lượng tối đa là 300 MB');
      } else {
        final dialog = LoadingDialog();
        final sendProgress = 0.0.obs;
        dialog.custom(
            loadingWidget: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Obx(() => CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: kAccentColor,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    value: sendProgress.value,
                  )),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Đang tải video',
                  style: CustomTheme.semiBold(16),
                ),
                Obx(() => Text(
                      '${(sendProgress.value * 100).round()} %',
                      style: CustomTheme.semiBold(16),
                    ))
              ],
            )
          ],
        ));
        final provider = ReviewProvider();
        final result = await provider
            .uploadVideo(
                courseId: courseController.course.courseId,
                categoryId: category.categoryId,
                contentId: listReview.first["id"],
                video: video,
                onSendProgress: (int count, int total) =>
                    sendProgress.value = count / total)
            .catchError((err) {
          dialog.error(message: '$err', callback: () => dialog.dismiss());
        });
        if (result != null && result) {
          dialog.succeed(
              message:
                  'Bạn đã upload video thành công!\nXin vui lòng đợi trong chốc lát!\nGiáo viên của chúng tôi sẽ nhận xét và chấm điểm cho video của bạn!',
              callback: () => dialog.dismiss());
        }
      }
    }
  }

  @override
  void onInit() {
    fetchReview();
    super.onInit();
  }
}
