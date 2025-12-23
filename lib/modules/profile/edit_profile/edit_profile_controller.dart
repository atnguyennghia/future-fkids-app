import 'dart:typed_data';
import 'package:futurekids/data/models/grade_model.dart';
import 'package:futurekids/data/models/profile_model.dart';
import 'package:futurekids/data/models/province_model.dart';
import 'package:futurekids/data/providers/grade_provider.dart';
import 'package:futurekids/data/providers/province_provider.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:futurekids/utils/loading_dialog.dart';
import 'package:futurekids/utils/notify.dart';
import 'package:futurekids/widgets/k_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/custom_theme.dart';
import '../../../utils/helper.dart';

class EditProfileController extends GetxController {
  final avatar = Uint8List(0).obs;
  final profile = Get.arguments["profile"] as ProfileModel;

  final txtName = TextEditingController();
  final txtNameFocusNode = FocusNode();

  final txtGrade = TextEditingController();
  final txtAge = TextEditingController();
  final txtGender = TextEditingController();
  final txtBirthday = TextEditingController();

  final txtEmail = TextEditingController();
  final txtEmailFocusNode = FocusNode();

  final txtMobile = TextEditingController();
  final txtMobileFocusNode = FocusNode();

  final txtProvince = TextEditingController();

  int? provinceId;

  final indexGrade = 0.obs;
  final indexAge = 0.obs;
  final indexGender = 0.obs;
  final listProvince = <ProvinceModel>[].obs;

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

  void fetchListProvince() async {
    final provider = ProvinceProvider();
    final result =
        await provider.getListProvince().catchError((err) => Notify.error(err));
    if (result != null) {
      listProvince.value = result;
    }
  }

  void loadCategory(
      {required List<Map<String, dynamic>> listItem,
      required RxInt selectedIndex,
      required TextEditingController txtController}) {
    final dialog = LoadingDialog();
    dialog.custom(
        loadingWidget: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 420,
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
          },
          title: 'Xác nhận',
          style: CustomTheme.semiBold(16).copyWith(color: Colors.white),
        )
      ],
    ));
    dialog.show();
  }

  void showDatePicker() {
    DatePicker.showDatePicker(Get.context!,
        minDateTime: DateTime.now().add(const Duration(days: -365 * 100)),
        maxDateTime: DateTime.now(),
        locale: DateTimePickerLocale.vi,
        dateFormat: 'dd/MM/yyyy',
        onConfirm: (dateTime, selectedIndex) =>
            txtBirthday.text = DateFormat('dd/MM/yyyy').format(dateTime),
        initialDateTime: txtBirthday.text.isEmpty
            ? DateTime.now()
            : DateFormat('dd/MM/yyyy').parse(txtBirthday.text));
  }

  bool validate() {
    if (txtName.text.isEmpty) {
      txtNameFocusNode.requestFocus();
      return false;
    }

    if (profile.typeAccount == 0) {
      if (txtEmail.text.isEmpty) {
        txtEmailFocusNode.requestFocus();
        return false;
      }

      if (txtMobile.text.isEmpty) {
        txtMobileFocusNode.requestFocus();
        return false;
      }

      if (!txtEmail.text.trim().isEmail) {
        Notify.error('Email không đúng định dạng');
        txtEmailFocusNode.requestFocus();
        return false;
      }

      if (!Helper.instance.isValidPhone(txtMobile.text.trim())) {
        Notify.error('Số điện thoại không đúng định dạng');
        txtMobileFocusNode.requestFocus();
        return false;
      }
    }

    if (profile.typeAccount != 0 && txtGrade.text.isEmpty) {
      loadCategory(
          listItem: listGrade.map((element) => element.toJson()).toList(),
          selectedIndex: indexGrade,
          txtController: txtGrade);
      return false;
    }

    if (profile.typeAccount != 0 && txtAge.text.isEmpty) {
      loadCategory(
          listItem: listAge, selectedIndex: indexAge, txtController: txtAge);
      return false;
    }

    if (profile.typeAccount != 0 && txtGender.text.isEmpty) {
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
      AuthService.to.saveUserModel(result);
    }
  }

  void onConfirm() async {
    if (validate()) {
      final dialog = LoadingDialog();
      dialog.show();

      final userProvider = UserProvider();
      final result = await userProvider
          .updateProfile(
              profileId: profile.id,
              name: txtName.text.trim(),
              grade: profile.typeAccount == 0
                  ? null
                  : listGrade[indexGrade.value].id,
              age: profile.typeAccount == 0
                  ? null
                  : listAge[indexAge.value]['id'],
              gender: profile.typeAccount == 0
                  ? null
                  : listGender[indexGender.value]['id'],
              avatar: avatar.value.isEmpty ? null : avatar.value,
              birthday: txtBirthday.text.isEmpty ? null : txtBirthday.text,
              provinceId: provinceId,
              email: profile.typeAccount == 0 ? txtEmail.text.trim() : null,
              mobile: profile.typeAccount == 0 ? txtMobile.text.trim() : null)
          .catchError((err) {
        dialog.error(message: '$err', callback: () => dialog.dismiss());
      });

      if (result != null && result) {
        getUser();
        dialog.dismiss();
        Get.back();
      }
    }
  }

  void showProvince() {
    Get.bottomSheet(
        Obx(() => listProvince.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: kAccentColor,
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        provinceId = listProvince[index].id;
                        txtProvince.text = listProvince[index].name;
                        Get.back();
                      },
                      title: Text(
                        '${listProvince[index].name}',
                        style: CustomTheme.semiBold(16),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listProvince.length)),
        backgroundColor: Colors.white);
  }

  @override
  void onInit() {
    fetchListGrade();
    fetchListProvince();

    txtName.text = profile.name;
    txtGrade.text = profile.className ?? '';
    for (int i = 0; i < listGrade.length; i++) {
      if (listGrade[i].id == profile.grade) {
        indexGrade.value = i;
      }
    }
    txtAge.text = profile.age.toString() + ' tuổi';
    for (int i = 0; i < listAge.length; i++) {
      if (listAge[i]["id"] == profile.age) {
        indexAge.value = i;
      }
    }
    txtGender.text = profile.gender == 0
        ? 'Nữ'
        : profile.gender == 1
            ? 'Nam'
            : 'Khác';
    for (int i = 0; i < listGender.length; i++) {
      if (listGender[i]["id"] == profile.gender) {
        indexGender.value = i;
      }
    }
    txtBirthday.text = profile.birthday ?? '';

    txtEmail.text = AuthService.to.userModel.value.email;
    txtMobile.text = AuthService.to.userModel.value.mobile;
    txtProvince.text = profile.provinceName ?? '';
    provinceId = profile.provinceId;
    super.onInit();
  }

  @override
  void onClose() {
    txtNameFocusNode.dispose();
    txtName.dispose();
    txtGrade.dispose();
    txtAge.dispose();
    txtGender.dispose();
    txtBirthday.dispose();
    txtEmailFocusNode.dispose();
    txtEmail.dispose();
    txtMobileFocusNode.dispose();
    txtMobile.dispose();
    txtProvince.dispose();
    super.onClose();
  }
}
