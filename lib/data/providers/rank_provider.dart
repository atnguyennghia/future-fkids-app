import 'package:dio/dio.dart';
import 'package:futurekids/data/models/profile_rank.dart';
import 'package:futurekids/utils/config.dart';

class RankProvider {
  final dio = Dio();

  RankProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<ProfileRankModel?> getProfileRank({required dynamic profileId,
    required dynamic classId,
    required dynamic subjectId,
    required type,
    required dynamic year,
    required dynamic page,
    dynamic month,
    dynamic week
  }) async {
    try {
      final response = await dio.get('/statistics?page_size=10&profile_id=$profileId&class_id=$classId&subject_id=$subjectId&year=$year&type=$type&page=$page&${month != null ? 'month' : 'week'}=${month ?? week}');

      if (response.statusCode == 200) {
        return ProfileRankModel.fromJson(response.data['data']);
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