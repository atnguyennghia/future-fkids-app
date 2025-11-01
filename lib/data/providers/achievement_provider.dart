import 'package:dio/dio.dart';
import 'package:futurekids/data/models/achievement_model.dart';
import 'package:futurekids/data/models/unit_model.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';

class AchievementProvider {
  final dio = Dio();

  AchievementProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<AchievementModel?> getAchievement({required dynamic profileId, required dynamic classId}) async {
    try {
      final response = await dio.get('/achievements?profile_id=$profileId&class_id=$classId');

      if (response.statusCode == 200) {
        return AchievementModel.fromJson(response.data['data'], classId, profileId);
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

  Future<List<UnitModel>?> getUnitHistory({required profileId, required dynamic bookId}) async {
    try {
      final response = await dio.get('/units/list?book_id=$bookId&profile_id=$profileId');

      if (response.statusCode == 200) {
        return response.data['data']['units'].map<UnitModel>((json) => UnitModel.fromJson(
            json,
            response.data['data']['is_actived'],
            response.data['data']['profile_units']
        )).toList();
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