import 'dart:typed_data';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/data/models/grade_model.dart';
import 'package:futurekids/data/providers/grade_provider.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  final avatar = (Get.arguments['avatar'] as Uint8List).obs;

  final showButton = true.obs;

  final txtName = TextEditingController();
  final txtNameFocusNode = FocusNode();
  final txtGrade = TextEditingController();
  final txtAge = TextEditingController();
  final txtGender = TextEditingController();

  final indexGrade = 0.obs;
  final indexAge = 0.obs;
  final indexGender = 0.obs;
  final listGrade = <GradeModel>[].obs;
  final listAge = <Map<String, dynamic>>[
    {"id": 5, "name": '5 tuổi'},
    {"id": 6, "name": '6 tuổi'},
    {"id": 7, "name": '7 tuổi'},
    {"id": 8, "name": '8 tuổi'},
    {"id": 9, "name": '9 tuổi'},
    {"id": 10, "name": '10 tuổi'},
    {"id": 11, "name": '11 tuổi'},
  ];
  final listGender = <Map<String, dynamic>>[
    {"id": 0, "name": 'Nữ'},
    {"id": 1, "name": 'Nam'},
    {"id": 2, "name": 'Khác'},
  ];

  void fetchListGrade() async {
    final provider = GradeProvider();
    final result =
        await provider.getListGrade().catchError((err) => Notify.error(err));
    if (result != null) {
      listGrade.value = result;
    }
  }

  void loadCategory(
      {required List<Map<String, dynamic>> listItem,
      required RxInt selectedIndex,
      required TextEditingController txtController}) {
    showButton.value = false;
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: kWidthMobile),
          height: Get.height * .75,
          child: Obx(() => CupertinoPicker(
              scrollController:
                  FixedExtentScrollController(initialItem: selectedIndex.value),
              selectionOverlay: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/left.svg',
                    width: 23.04,
                    height: 37.71,
                  ),
                  SvgPicture.asset(
                    'assets/icons/right.svg',
                    width: 23.04,
                    height: 37.71,
                  )
                ],
              ),
              itemExtent: 80,
              looping: true,
              onSelectedItemChanged: (index) => selectedIndex.value = index,
              children: listItem
                  .map((item) => Center(
                        child: Container(
                          width:
                              item == listItem[selectedIndex.value] ? 240 : 200,
                          height:
                              item == listItem[selectedIndex.value] ? 60 : 50,
                          decoration: BoxDecoration(
                              color: item == listItem[selectedIndex.value]
                                  ? kAccentColor
                                  : const Color(0xFFEBEBEB),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              item['name'],
                              style: item == listItem[selectedIndex.value]
                                  ? CustomTheme.semiBold(18)
                                      .copyWith(color: Colors.white)
                                  : CustomTheme.medium(16)
                                      .copyWith(color: kNeutral2Color),
                            ),
                          ),
                        ),
                      ))
                  .toList())),
        ),
        KButton(
          onTap: () {
            dialog.dismiss();
            txtController.text = listItem[selectedIndex.value]['name'];
            showButton.value = true;
          },
          title: 'Xác nhận',
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
        )
      ],
    ));
    dialog.show();
  }

  bool validate() {
    if (txtName.text.isEmpty) {
      txtNameFocusNode.requestFocus();
      return false;
    }

    if (txtGrade.text.isEmpty) {
      loadCategory(
          listItem: listGrade.map((e) => e.toJson()).toList(),
          selectedIndex: indexGrade,
          txtController: txtGrade);
      return false;
    }

    if (txtAge.text.isEmpty) {
      loadCategory(
          listItem: listAge, selectedIndex: indexAge, txtController: txtAge);
      return false;
    }

    if (txtGender.text.isEmpty) {
      loadCategory(
          listItem: listGender,
          selectedIndex: indexGender,
          txtController: txtGender);
      return false;
    }

    return true;
  }

  void getUser() async {
    final userProvider = UserProvider();
    final result =
        await userProvider.getUser().catchError((err) => Notify.error(err));
    if (result != null) {
      AuthService.to.userModel.value = result;
    }
  }

  ///Tao profile
  void onConfirm() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final userProvider = UserProvider();
      final result = await userProvider
          .createProfile(
              txtName.text,
              listGrade[indexGrade.value].id,
              listAge[indexAge.value]['id'],
              listGender[indexGender.value]['id'],
              avatar.value)
          .catchError((err) {
        dialog.error(message: '$err', callback: () => dialog.dismiss());
      });

      if (result != null && result) {
        getUser();
        dialog.succeed(
            message: 'Tạo tài khoản cho bé thành công!',
            callback: () {
              dialog.dismiss();
              Get.back();
            });
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    fetchListGrade();
  }

  @override
  void onClose() {
    super.onClose();

    txtNameFocusNode.dispose();
    txtName.dispose();
    txtGrade.dispose();
    txtAge.dispose();
    txtGender.dispose();
  }
}
