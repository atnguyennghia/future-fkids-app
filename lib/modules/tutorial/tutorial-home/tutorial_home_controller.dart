import 'package:futurekids/utils/loading_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TutorialHomeController extends GetxController {
  final step = 1.obs;

  void onContinue() {
    if (step.value < 6) {
      step.value += 1;
    } else {
      final _dialog = LoadingDialog();
      bool isClosing = false;
      _dialog.show();
      _dialog.succeed(
          message: 'Còn bây giờ, chúng ta bắt đầu học nào!',
          callback: () {
            isClosing = true;
            GetStorage().write('first_login', 1);
            _dialog.dismiss();
            Get.offAllNamed('/profile');
          });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (!isClosing) {
          GetStorage().write('first_login', 1);
          _dialog.dismiss();
          Get.offAllNamed('/profile');
        }
      });
    }
  }

  void onCancel() {
    GetStorage().write('first_login', 1);
    Get.offAllNamed('/profile');
  }

  String getTextByStep() {
    switch (step.value) {
      case 1:
        return 'Phụ huynh có thể thay đổi giữa các tài khoản ở đây.';
      case 2:
        return 'Những bài học gần nhất sẽ được hiện như trên.';
      case 3:
        return 'Đối với tài khoản phụ huynh sẽ hiển thị đầy đủ môn học và các khối lớp. Chọn môn học và khối lớp bạn muốn để bắt đầu học nhé!';
      case 4:
        return 'Ấn vào Thành tích để xem chi tiết kết quả đã đạt được trong quá trình học của con nhé!';
      case 5:
        return 'Để biết thứ hạng và phần quà mà con nhận được hãy ấn vào "Xếp hạng" nhé!';
      case 6:
        return 'Ấn vào Cá nhân để xem và chỉnh sửa thông tin cá nhân.';
      default:
        return '';
    }
  }
}
