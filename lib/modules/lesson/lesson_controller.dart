import 'package:futurekids/data/models/lesson_model.dart';
import 'package:futurekids/data/models/unit_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/unit/unit_controller.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';

class LessonController extends GetxController {
  final unitController = Get.find<UnitController>();
  final unit = Get.arguments["unit"] as UnitModel;
  final avatar = Get.arguments["avatar"] as String;

  final listLesson = <LessonModel>[].obs;

  void fetchLesson() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListLesson(unitId: unit.unitId)
        .catchError((err) {
      Notify.error(err);
    });

    if (result != null) {
      result[0].isExpanded = true;
      listLesson.value = result;
    }
  }

  void onClickedWhenLock() {
    final _dialog = LoadingDialog();
    if (AuthService.to.hasLogin) {
      _dialog.succeed(
          message: 'Hãy nâng cấp VIP để vào xem\ntoàn bộ bài học bạn nhé!',
          title: 'Kích hoạt thẻ',
          showClose: true,
          callback: () {
            _dialog.dismiss();
            Get.toNamed('/personal/card');
          });
    } else {
      _dialog.succeed(
          message: 'Hãy đăng nhập để vào xem\nbài học mới bạn nhé!',
          title: 'Đăng nhập',
          showClose: true,
          callback: () {
            _dialog.dismiss();
            Get.toNamed('/auth/login');
          });
    }
    _dialog.show();
  }

  @override
  void onInit() {
    fetchLesson();
    super.onInit();
  }
}
