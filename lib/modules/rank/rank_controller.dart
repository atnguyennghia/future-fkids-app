import 'package:futurekids/components/select_class/select_class_view.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:get/get.dart';

class RankController extends GetxController {
  void showPopupSelectClass({required dynamic subjectId}) {
    final dialog = LoadingDialog();
    dialog.custom(
        dismissable: true,
        loadingWidget: SelectClassView(callback: (classId, className) {
          dialog.dismiss();
          Get.toNamed('/rank/detail', arguments: {"class_id": classId, "class_name": className, "subject_id": subjectId});
        },)
    );
  }
}
