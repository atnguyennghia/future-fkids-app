import 'package:dio/dio.dart';
import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/models/card_model.dart';
import 'package:futurekids/data/models/user_model.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';

class UserProvider {
  final dio = Dio();

  UserProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthService.to.authModel?.accessToken}'
    };
  }

  Future<UserModel?> getUser() async {
    try {
      final response = await dio.post('/auth/user', data: {});

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 401) {
          throw '401';
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<dynamic> createProfile(dynamic name, dynamic grade, dynamic age,
      dynamic gender, dynamic avatar) async {
    try {
      final data = FormData.fromMap({
        "name": name,
        "class": grade,
        "age": age,
        "gender": gender,
        "avatar": MultipartFile.fromBytes(avatar, filename: 'avatar.png')
      });
      final response = await dio.post('/profile/create', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> updateProfile(
      {dynamic profileId,
      dynamic name,
      dynamic grade,
      dynamic age,
      dynamic gender,
      dynamic avatar,
      dynamic birthday,
      dynamic provinceId,
      dynamic email,
      dynamic mobile}) async {
    try {
      final data = {"profile_id": profileId, "name": name};

      if (grade != null) {
        data["class"] = grade;
      }

      if (age != null) {
        data["age"] = age;
      }

      if (gender != null) {
        data["gender"] = gender;
      }

      if (birthday != null) {
        data["birthday"] = birthday;
      }

      if (provinceId != null) {
        data["province_id"] = provinceId;
      }

      if (email != null) {
        data["email"] = email;
      }

      if (mobile != null) {
        data["mobile"] = mobile;
      }

      if (avatar != null) {
        data["avatar"] =
            MultipartFile.fromBytes(avatar, filename: 'avatar.png');
      }

      final response =
          await dio.post('/profile/update', data: FormData.fromMap(data));

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> activeCard(dynamic code) async {
    try {
      final data = {"code": code};
      final response = await dio.post('/active/send', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> getListCard() async {
    try {
      final response = await dio.get('/active/list');

      if (response.statusCode == 200) {
        return {
          "active": response.data['data']['actived']
              .map<CardModel>((json) => CardModel.fromJson(json))
              .toList(),
          "expire": response.data['data']['expired']
              .map<CardModel>((json) => CardModel.fromJson(json))
              .toList(),
        };
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<BookModel>?> getListStudying({dynamic profileId}) async {
    try {
      final response = await dio.get('/studying?profile_id=$profileId');

      if (response.statusCode == 200) {
        return response.data['data']
            .map<BookModel>((json) => BookModel(
                id: json['book_id'],
                name: json['book_name'],
                description: json['book_description'],
                subjectId: json['subject_id'],
                classId: json['class_id'],
                image: json['image']))
            .toList();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<dynamic> updatePassword(
      {dynamic passwordOld,
      dynamic passwordNew,
      dynamic passwordConfirm}) async {
    try {
      final data = {
        "password_old": passwordOld,
        "password_new": passwordNew,
        "password_confirm": passwordConfirm
      };
      final response = await dio.post('/auth/update-password', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<dynamic> deleteUser({
    dynamic reason,
    dynamic password,
  }) async {
    try {
      final data = {
        "reason": reason,
        "password": password,
      };
      final response = await dio.delete('/auth/delete', data: data);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 400) {
          throw e.response?.data['message'];
        }
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
