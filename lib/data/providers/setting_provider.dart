import 'package:dio/dio.dart';
import 'package:futurekids/utils/config.dart';

class SettingProvider {
  final dio = Dio();

  SettingProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {'Accept': 'application/json'};
  }

  Future<dynamic> getSettingByVersion({required dynamic version}) async {
    try {
      final params = {
        'version': version,
      };
      final response =
          await dio.get('/setting-version', queryParameters: params);

      if (response.statusCode == 200) {
        return response.data['data'];
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
