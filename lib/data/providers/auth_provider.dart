import 'package:dio/dio.dart';
import 'package:futurekids/data/models/auth_model.dart';
import 'package:futurekids/utils/config.dart';

class AuthProvider {
  final dio = Dio();

  AuthProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<dynamic> register(dynamic name, dynamic email, dynamic mobile, dynamic password) async {
    try {
      final data = '{"name": "$name", "email": "$email", "mobile": "$mobile", "password": "$password"}';
      final response = await dio.post('/auth/register', data: data);

      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          if (e.response?.data['message']['email'] != null) {
            throw e.response?.data['message']['email'].toList()[0];
          }
          if (e.response?.data['message']['mobile'] != null) {
            throw e.response?.data['message']['mobile'].toList()[0];
          }
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<AuthModel?> login(dynamic email, dynamic password) async {
    try {
      final data = '{"email": "$email", "password": "$password"}';
      final response = await dio.post('/auth/login', data: data);

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data['data']);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw e.response?.data['message'];
      }
      if (e.response?.statusCode == 401) {
        throw e.response?.data['message'];
      }
      throw e.message;
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<dynamic> sendEmailOTP(dynamic email) async {
    try {
      final data = '{"email": "$email"}';
      final response = await dio.post('/auth/forgot-password/send', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw e.response?.data['message'];
      }
      throw e.message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> confirmOTP(dynamic email, dynamic otp) async {
    try {
      final data = '{"email": "$email", "otp": "$otp"}';
      final response = await dio.post('/auth/forgot-password/confirm', data: data);

      if (response.statusCode == 200) {
        return response.data['data']['user_id'];
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw 'Mã OTP Không chính xác\nVui lòng thử lại!';
      }
      throw e.message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> resetPassword(dynamic userId, dynamic passwordNew, dynamic passwordConfirm) async {
    try {
      final data = '{"user_id": "$userId", "password_new": "$passwordNew", "password_confirm": "$passwordConfirm"}';
      final response = await dio.post('/auth/forgot-password/change', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        if (e.response?.data['message']['password_confirm'] != null) {
          throw 'Mật khẩu không trùng khớp\nVui lòng nhập lại';
        }
        throw e.response?.data['message'];
      }
      throw e.message;
    } catch (e) {
      throw e.toString();
    }
  }
}