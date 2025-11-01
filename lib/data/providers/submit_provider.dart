import 'package:dio/dio.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';

class SubmitProvider {
  final dio = Dio();
  SubmitProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthService.to.authModel?.accessToken}'
    };
  }

  Future<dynamic> submitData(
      {required dynamic profileId,
      required dynamic courseId,
      required dynamic categoryId,
      required dynamic contentId,
      required dynamic point,
      required dynamic percentComplete}) async {
    try {
      final data = {
        "profile_id": profileId,
        "course_id": courseId,
        "category_id": categoryId,
        "content_id": contentId,
        "point": point,
        "percent_complete": percentComplete
      };

      final response = await dio.post('/contents/submit', data: data);

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
