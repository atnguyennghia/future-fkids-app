import 'dart:developer' as developer;
import 'package:futurekids/data/models/auth_model.dart';
import 'package:futurekids/data/models/profile_model.dart';
import 'package:futurekids/data/models/user_model.dart';
import 'package:futurekids/data/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  AuthModel? authModel;
  final userModel = UserModel().obs;
  final profileModel = ProfileModel().obs;
  final _isLoggedIn = false.obs;

  Future<AuthService> init() async {
    try {
      // Load authModel từ storage
      final authData = GetStorage().read('auth_model');
      if (authData != null) {
        // Đảm bảo data là Map để parse
        if (authData is Map<String, dynamic>) {
          authModel = AuthModel.fromJson(authData);
          _isLoggedIn.value = true;
        } else if (authData is Map) {
          authModel = AuthModel.fromJson(Map<String, dynamic>.from(authData));
          _isLoggedIn.value = true;
        } else {
          // Nếu data không phải Map, có thể là object cũ - xóa và reset
          developer.log(
            'Invalid auth_model data type: ${authData.runtimeType}, removing...',
            name: 'AuthService',
            level: 900, // Warning level
          );
          GetStorage().remove('auth_model');
          authModel = null;
          _isLoggedIn.value = false;
        }
      } else {
        _isLoggedIn.value = false;
      }

      // Load userModel từ storage
      if (_isLoggedIn.value) {
        try {
          final userData = GetStorage().read('user_model');
          if (userData != null && userData is Map) {
            userModel.value = UserModel.fromJson(Map<String, dynamic>.from(userData));
            developer.log(
              'UserModel loaded from storage',
              name: 'AuthService',
              level: 800,
            );
          }
        } catch (e) {
          developer.log(
            'Error loading user_model from storage: $e',
            name: 'AuthService',
            level: 1000,
          );
        }

        // Load profileModel từ storage
        try {
          final profileData = GetStorage().read('profile_model');
          if (profileData != null && profileData is Map) {
            profileModel.value = ProfileModel.fromJson(Map<String, dynamic>.from(profileData));
            developer.log(
              'ProfileModel loaded from storage',
              name: 'AuthService',
              level: 800,
            );
          }
        } catch (e) {
          developer.log(
            'Error loading profile_model from storage: $e',
            name: 'AuthService',
            level: 1000,
          );
        }

        // Nếu đã có authModel nhưng chưa có userModel, load từ API
        if (userModel.value.id == null) {
          _loadUserInfo();
        }
      }
    } catch (e, stackTrace) {
      developer.log(
        'Error loading auth_model from storage: $e',
        name: 'AuthService',
        error: e,
        stackTrace: stackTrace,
        level: 1000, // Error level
      );
      GetStorage().remove('auth_model');
      authModel = null;
      _isLoggedIn.value = false;
    }

    return this;
  }

  bool get hasLogin => _isLoggedIn.value;

  void login(AuthModel authModel, String username) {
    this.authModel = authModel;
    _isLoggedIn.value = true;
    // Lưu dưới dạng JSON vào storage
    GetStorage().write('auth_model', authModel.toJson());
    GetStorage().write('username', username);
    developer.log(
      'User logged in successfully: $username',
      name: 'AuthService',
      level: 800, // Info level
    );
    // Load user info ngay sau khi login
    _loadUserInfo();
  }

  // Load user info từ API
  Future<void> _loadUserInfo() async {
    try {
      final userProvider = UserProvider();
      final result = await userProvider.getUser().catchError((err) {
        developer.log(
          'Error loading user info: $err',
          name: 'AuthService',
          level: 1000, // Error level
        );
        return null;
      });
      if (result != null) {
        userModel.value = result;
        // Lưu userModel vào storage
        GetStorage().write('user_model', result.toJson());
        
        // Tự động chọn profile đầu tiên nếu chưa có profile được chọn
        if (result.profile != null && result.profile!.isNotEmpty) {
          if (profileModel.value.id == null) {
            profileModel.value = result.profile![0];
            // Lưu profileModel vào storage
            GetStorage().write('profile_model', profileModel.value.toJson());
          }
        }
        developer.log(
          'User info loaded successfully and saved to storage',
          name: 'AuthService',
          level: 800, // Info level
        );
      }
    } catch (e) {
      developer.log(
        'Error loading user info: $e',
        name: 'AuthService',
        level: 1000, // Error level
      );
    }
  }

  void logout() {
    authModel = null;
    _isLoggedIn.value = false;
    userModel.value = UserModel();
    profileModel.value = ProfileModel();
    // Remove khỏi storage khi logout
    GetStorage().remove('auth_model');
    GetStorage().remove('user_model');
    GetStorage().remove('profile_model');
    GetStorage().remove('username');
    developer.log(
      'User logged out successfully and all data removed from storage',
      name: 'AuthService',
      level: 800, // Info level
    );
  }

  // Helper method để lưu profileModel khi được cập nhật
  void saveProfileModel(ProfileModel profile) {
    profileModel.value = profile;
    GetStorage().write('profile_model', profile.toJson());
    developer.log(
      'ProfileModel saved to storage',
      name: 'AuthService',
      level: 800,
    );
  }

  // Helper method để lưu userModel khi được cập nhật
  void saveUserModel(UserModel user) {
    // Lưu profileModel hiện tại để so sánh
    final currentProfileId = profileModel.value.id;
    
    userModel.value = user;
    GetStorage().write('user_model', user.toJson());
    
    // Nếu có profile list và profile hiện tại vẫn còn trong list, cập nhật profileModel
    if (user.profile != null && user.profile!.isNotEmpty && currentProfileId != null) {
      final updatedProfile = user.profile!.firstWhere(
        (p) => p.id == currentProfileId,
        orElse: () => user.profile![0], // Nếu không tìm thấy, chọn profile đầu tiên
      );
      saveProfileModel(updatedProfile);
      developer.log(
        'ProfileModel updated automatically after UserModel update',
        name: 'AuthService',
        level: 800,
      );
    } else if (user.profile != null && user.profile!.isNotEmpty) {
      // Nếu chưa có profile được chọn, chọn profile đầu tiên
      saveProfileModel(user.profile![0]);
    }
    
    developer.log(
      'UserModel saved to storage',
      name: 'AuthService',
      level: 800,
    );
  }
}