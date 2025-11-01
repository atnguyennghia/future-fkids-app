import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/models/unit_model.dart';
import 'package:futurekids/data/providers/course_provider.dart';
import 'package:futurekids/modules/home/widgets/book_widget.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UnitController extends GetxController {
  final book = (Get.arguments['book'] as BookModel).obs;

  final activeUnitIndex = 0.obs;

  final listUnit = <UnitModel>[].obs;

  void fetchUnit() async {
    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListUnit(bookId: book.value.id)
        .catchError((err) {
      Notify.error(err);
    });

    if (result != null) {
      listUnit.value = result;
      for (int i = 0; i < listUnit.length; i++) {
        if (listUnit[i].status == 0) {
          activeUnitIndex.value = i;
        }
      }
    }
  }

  void onBookClick() async {
    final dialog = LoadingDialog();
    dialog.show();

    final courseProvider = CourseProvider();
    final result = await courseProvider
        .getListBook(
            classId: book.value.classId, subjectId: book.value.subjectId)
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

      ///show popup select book
      final key =
          '${AuthService.to.profileModel.value.id}_${book.value.subjectId}_${book.value.classId}';
      dialog.custom(
          dismissable: true,
          loadingWidget: BookWidget(
              listBook: result,
              callback: (_book) {
                dialog.dismiss();
                GetStorage().write(key, _book.toJson());

                ///reset data
                book.value = _book;
                activeUnitIndex.value = 0;
                listUnit.value = [];
                fetchUnit();
              }));
    }
  }

  @override
  void onInit() {
    fetchUnit();
    super.onInit();
  }
}
