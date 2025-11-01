import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SelectAvatarController extends GetxController {
  final avatarCarouselController = CarouselSliderController();

  final avatar = Uint8List(0).obs;

  void loadFile(String path) async {
    final _file = await rootBundle.load(path);
    avatar.value =
        _file.buffer.asUint8List(_file.offsetInBytes, _file.lengthInBytes);
  }

  void onPickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      avatar.value = await image.readAsBytes();
    }
  }

  void onConfirm() {
    final _argument = Get.arguments;
    if (_argument != null) {
      _argument['controller'].avatar.value = avatar.value;
      Get.back();
    } else {
      Get.offAndToNamed('/profile/create-profile',
          arguments: {"avatar": avatar.value});
    }
  }

  @override
  void onInit() {
    final _argument = Get.arguments;
    if (_argument != null) {
      avatar.value = _argument['controller'].avatar.value;
    } else {
      loadFile('assets/avatars/0.png');
    }
    super.onInit();
  }
}
