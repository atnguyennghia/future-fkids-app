import 'package:dio/dio.dart';
import 'package:futurekids/utils/config.dart';

class RegulationProvider {
  final dio = Dio();

  RegulationProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<dynamic> getRegulation({required dynamic type}) async {
    try {
      final response = await dio.get('/regulations?type=$type');

      if (response.statusCode == 200) {
        return response.data['data'][0];
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