// import 'package:awesome_notifications/awesome_notifications.dart';  // Tạm thời comment
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  final valueSwitch = false.obs;
  final timeValue = DateTime.now().obs;

  void save() async {
    // Tạm thời comment awesome_notifications
    _showSucceedDialog();
    // if (valueSwitch.value) {
    //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //     if (!isAllowed) {
    //       _requestPermission();
    //     } else {
    //       _scheduleNotify();
    //       _showSucceedDialog();
    //     }
    //   });
    // } else {
    //   _removeScheduleNotify();
    //   _showSucceedDialog();
    // }
  }

  void _showSucceedDialog() async {
    final _dialog = LoadingDialog();
    _dialog.show();

    await GetStorage().write(
      'reminder',
      {'enable': valueSwitch.value, 'time': timeValue.value.toString()},
    );

    _dialog.succeed(
      message: 'Thông tin cài đặt đã được cập nhật!',
      callback: () => _dialog.dismiss(),
    );
  }

  // Tạm thời comment awesome_notifications
  // void _requestPermission() {
  //   showDialog(
  //     context: Get.context!,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Cho phép thông báo'),
  //       content: const Text('FKIDS muốn gửi thông báo cho bạn'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: Text(
  //             'Không đồng ý',
  //             style: CustomTheme.semiBold(16).copyWith(color: kPrimaryColor),
  //           ),
  //         ),
  //         TextButton(
  //           onPressed: () => AwesomeNotifications()
  //               .requestPermissionToSendNotifications()
  //               .then((_) => Get.back()),
  //           child: Text(
  //             'Đồng ý',
  //             style: CustomTheme.semiBold(16),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Tạm thời comment awesome_notifications
  // void _removeScheduleNotify() async {
  //   await AwesomeNotifications().cancel(99);
  // }

  // void _scheduleNotify() async {
  //   String localTimeZone =
  //       await AwesomeNotifications().getLocalTimeZoneIdentifier();

  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 99,
  //       channelKey: 'fkids_channel',
  //       title: 'Xin chào! Fubo đây!',
  //       body: 'Bạn ơi! Hãy dành chút thời gian để học và ôn tập lại bài nhé!',
  //       wakeUpScreen: true,
  //     ),
  //     schedule: NotificationCalendar(
  //       second: 0,
  //       minute: timeValue.value.minute,
  //       hour: timeValue.value.hour,
  //       timeZone: localTimeZone,
  //       preciseAlarm: true,
  //       repeats: true,
  //       allowWhileIdle: true,
  //     ),
  //   );
  // }

  void showDatePicker() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => Container(
        height: 500,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (val) => timeValue.value = val,
              ),
            ),
            CupertinoButton(
                child: const Text('OK'), onPressed: () => Get.back()),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    final _tmp = GetStorage().read('reminder');
    if (_tmp != null) {
      valueSwitch.value = _tmp['enable'];
      timeValue.value = DateTime.parse(_tmp['time']);
    }
    super.onInit();
  }
}
