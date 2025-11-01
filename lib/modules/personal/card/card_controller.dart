import 'package:futurekids/data/models/card_model.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/loading_dialog.dart';

class CardController extends GetxController {
  final txtCardNumber = TextEditingController();
  final txtCardNumberFocusNode = FocusNode();

  final listCardActive = <CardModel>[].obs;
  final listCardExpire = <CardModel>[].obs;

  void fetchListCard() async {
    final _provider = UserProvider();
    final _result = await _provider.getListCard().catchError((err) {
      Notify.error(err);
    });

    if (_result != null) {
      if (_result['active'] != null) {
        listCardActive.value = _result['active'];
      }
      if (_result['expire'] != null) {
        listCardExpire.value = _result['expire'];
      }
    }
  }

  bool validate() {
    if (txtCardNumber.text.isEmpty) {
      txtCardNumberFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  void onActive() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      ///Call API active card number
      final userProvider = UserProvider();
      final result =
          await userProvider.activeCard(txtCardNumber.text).catchError((err) {
        dialog.error(
            // message: 'Mã thẻ của bạn chưa đúng\nXin vui lòng nhập lại!',
            message: err.toString(),
            callback: () async {
              dialog.dismiss();
            });
      });

      if (result != null && result) {
        dialog.succeed(
            message: 'Mã thẻ của bạn đã được\nkích hoạt thành công!',
            callback: () async {
              dialog.dismiss();
              fetchListCard();
              txtCardNumber.text = '';
            });
      }
    }
  }

  @override
  void onInit() {
    fetchListCard();
    super.onInit();
  }

  @override
  void onClose() {
    txtCardNumber.dispose();
    txtCardNumberFocusNode.dispose();
    super.onClose();
  }
}
