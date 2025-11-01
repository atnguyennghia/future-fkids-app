import 'package:futurekids/data/models/auth_model.dart';
import 'package:futurekids/data/models/profile_model.dart';
import 'package:futurekids/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  AuthModel? authModel;
  final userModel = UserModel().obs;
  final profileModel = ProfileModel().obs;

  Future<AuthService> init() async {
    final data = GetStorage().read('auth_model');
    if (data != null) {
      authModel = AuthModel.fromJson(GetStorage().read('auth_model'));
    }

    return this;
  }

  bool get hasLogin => authModel != null;

  void login(AuthModel authModel, String username) {
    this.authModel = authModel;
    GetStorage().write('auth_model', authModel);
    GetStorage().write('username', username);
  }

  void logout() {
    authModel = null;
    userModel.value = UserModel();
    profileModel.value = ProfileModel();
    GetStorage().remove('auth_model');
  }
}