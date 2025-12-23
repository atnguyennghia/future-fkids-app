import 'package:futurekids/data/models/card_model.dart';
import 'package:futurekids/data/models/profile_model.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/services/setting_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:futurekids/widgets/k_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_store/open_store.dart';

import 'html_reload_app.dart' if (dart.library.html) 'html_reload.dart';

class ProfileController extends GetxController {
  final txtCardNumber = TextEditingController();
  final txtCardNumberFocusNode = FocusNode();

  final status = 0.obs;

  bool validate() {
    if (txtCardNumber.text.isEmpty) {
      txtCardNumberFocusNode.requestFocus();
      return false;
    }

    return true;
  }

  Future<void> courseActivation() async {
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 88,
              color: Colors.transparent,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: kWidthMobile),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.topRight,
                      height: 48,
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => dialog.dismiss(),
                        child: const Icon(
                          Icons.close,
                          color: kPrimaryColor,
                          size: 32,
                        ),
                      )),
                  Text(
                    'Kích hoạt khóa học',
                    textAlign: TextAlign.center,
                    style: CustomTheme.semiBold(20).copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Nhập mã kích hoạt của bạn vào ô dưới đây',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '(Nếu có)',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral3Color),
                  ),
                  Container(
                    width: 302,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: KTextField(
                      controller: txtCardNumber,
                      focusNode: txtCardNumberFocusNode,
                      radius: 6,
                      textAlign: TextAlign.center,
                      hintText: 'Nhập mã*',
                    ),
                  ),
                  KButton(
                    onTap: () => onActive(dialog),
                    title: 'Kích hoạt',
                    style:
                        CustomTheme.semiBold(16).copyWith(color: Colors.white),
                    width: 276,
                    backgroundColor: BackgroundColor.accent,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Nếu bạn gặp vấn đề trong quá trình kích hoạt mã. Vui lòng liên hệ với bộ phận CSKH của chúng tôi để được hỗ trợ.',
                    style:
                        CustomTheme.medium(16).copyWith(color: kNeutral2Color),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'HOTLINE: 0855 768 887',
                    style:
                        CustomTheme.medium(16).copyWith(color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            width: 118.18,
            child: Image.asset(
              'assets/images/fubo_succeed.gif',
              width: 118.18,
              height: 131.13,
            )),
      ],
    ));
    dialog.show();
  }

  void onActive(LoadingDialog refDialog) async {
    if (validate()) {
      refDialog.dismiss();
      final dialog = LoadingDialog();
      dialog.show();

      ///Call API active card number
      final userProvider = UserProvider();
      final result =
          await userProvider.activeCard(txtCardNumber.text).catchError((err) {
        dialog.error(
            message: 'Mã thẻ của bạn chưa đúng\nXin vui lòng nhập lại!',
            callback: () async {
              dialog.dismiss();
              await courseActivation();
            });
      });

      if (result != null && result) {
        dialog.succeed(
            message: 'Mã thẻ của bạn đã được\nkích hoạt thành công!',
            callback: () async {
              dialog.dismiss();
            });
      }
    }
  }

  void getUser() async {
    final userProvider = UserProvider();
    final result = await userProvider.getUser().catchError((err) {
      if (err == '401') {
        status.value = 401;
      } else {
        Notify.error(err);
      }
    });
    if (result != null) {
      status.value = 1;
      AuthService.to.saveUserModel(result);

      if (GetStorage().read('first_login') == null) {
        final _dialog = LoadingDialog();
        _dialog.show();
        _dialog.succeed(
          message:
              'Tớ là Fubo, cùng tớ khám phá những điều thú vị tại FutureKids nào!',
          callback: () {
            _dialog.dismiss();
            Get.offAllNamed('/tutorial-profile');
          },
        );
      } else {
        if (SettingService.to.isShowActiveCard) {
          ///Check user has card active now
          final listCard = await userProvider
              .getListCard()
              .catchError((err) => Notify.error(err));
          if ((listCard["active"] as List<CardModel>).isEmpty) {
            courseActivation();
          }
        }
      }
    }
  }

  void onSelectProfile(ProfileModel profile) {
    AuthService.to.saveProfileModel(profile);
    Get.offAndToNamed('/');
  }

  void _forceUpdate() {
    final _dialog = LoadingDialog();
    _dialog.show();
    _dialog.succeed(
        message:
            'Đã có phiên bản mới, vui lòng cập nhật để tiếp tục sử dụng ứng dụng',
        callback: () {
          _dialog.dismiss();
          //redirect to store
          if (!kIsWeb) {
            OpenStore.instance.open(
              appStoreId: '6443865496',
              androidAppBundleId: 'vn.edu.futurelang.fkids',
            );
          } else {
            htmlReload();
          }
        });
  }

  @override
  void onReady() {
    super.onReady();

    if (SettingService.to.isNewVersion) {
      getUser();
    } else {
      _forceUpdate();
    }
  }

  @override
  void onClose() {
    txtCardNumberFocusNode.dispose();
    txtCardNumber.dispose();

    super.onClose();
  }
}
