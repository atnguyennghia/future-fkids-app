import 'package:dio/dio.dart';
import 'package:futurekids/utils/config.dart';

class ReasonProvider {
  final dio = Dio();

  ReasonProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {'Accept': 'application/json'};
  }

  Future<dynamic> getListResons() async {
    try {
      final response = await dio.get('/reasons');

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
