import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/home/widgets/book_widget.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/services/setting_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  void onSubjectClick({dynamic classId, dynamic subjectId}) async {
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
      ///Nếu không có giáo trình thì thông báo
      if (result.isEmpty) {
        dialog.dismiss();
        Notify.warning('Không tìm thấy chương trình học!');
        return;
      }

      ///Nếu chỉ có 1 giáo trình thì vào học luôn
      if (result.length == 1) {
        dialog.dismiss();
        Get.toNamed('/unit', arguments: {"book": result[0]});
        return;
      }

      ///Nếu có 2 giáo trình trở lên thì kiểm tra xem đã chọn chưa
      ///Nếu đã chọn trước đó thì vào luôn
      final key =
          '${AuthService.to.profileModel.value.id}_${subjectId}_$classId';
      final data = GetStorage().read(key); //profileId_subjectId_classId
      if (data != null) {
        final book = BookModel.fromJson(data);
        for (var item in result) {
          if (item.id == book.id) {
            dialog.dismiss();
            Get.toNamed('/unit', arguments: {"book": book});
            return;
          }
        }
      }

      ///show popup select book
      dialog.custom(
          dismissable: true,
          loadingWidget: BookWidget(
              listBook: result,
              callback: (book) {
                dialog.dismiss();
                GetStorage().write(key, book.toJson());
                Get.toNamed('/unit', arguments: {"book": book});
              }));
    }
  }

  void _showAlert() {
    final _dialog = LoadingDialog();
    _dialog.show();
    _dialog.succeed(
        message: SettingService.to.contentNotification,
        callback: () => _dialog.dismiss(),
        showClose: true);
  }

  @override
  void onReady() {
    if (SettingService.to.isShowNotification) {
      _showAlert();
    }
    super.onReady();
  }
}
