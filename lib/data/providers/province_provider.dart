import 'package:dio/dio.dart';
import 'package:futurekids/data/models/province_model.dart';
import 'package:futurekids/utils/config.dart';

class ProvinceProvider {
  final dio = Dio();

  ProvinceProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<List<ProvinceModel>?> getListProvince() async {
    try {
      final response = await dio.get('/provinces');

      if (response.statusCode == 200) {
        return response.data['data'].map<ProvinceModel>((json) => ProvinceModel.fromJson(json)).toList();
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