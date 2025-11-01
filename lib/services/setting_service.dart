import 'package:futurekids/data/providers/setting_provider.dart';
import 'package:futurekids/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SettingService extends GetxService {
  static SettingService get to => Get.find();

  bool isShowActiveCard = false;
  bool isShowNotification = false;
  bool isNewVersion = false;

  String contentNotification = '';

  Future<SettingService> init() async {
    final _provider = SettingProvider();
    final _result = await _provider
        .getSettingByVersion(
            version: kIsWeb
                ? kVersionWeb
                : GetPlatform.isIOS
                    ? kVersionIOS
                    : kVersionAndroid)
        .catchError((err) {
      printError(info: err.toString());
    });

    if (_result != null) {
      if (_result['active_card'] != null) {
        isShowActiveCard = _result['active_card'] == 1;
      }
      if (_result['active_noti'] != null) {
        isShowNotification = _result['active_noti'] == 1;
        contentNotification = _result['notification'] ?? '';
      }
      if (_result['is_new'] != null) {
        isNewVersion = kIsWeb ? true : _result['is_new'] == 1;
      }
    }

    return this;
  }
}
