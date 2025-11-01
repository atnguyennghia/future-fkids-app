import 'package:dio/dio.dart';

import '../../services/auth_service.dart';
import '../../utils/config.dart';

class IAPProvider {
  final dio = Dio();

  IAPProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthService.to.authModel?.accessToken}'
    };
  }

  Future<dynamic> getListProduct() async {
    try {
      final response = await dio.get('/group-cards');

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

  Future<dynamic> purchaseCard({
    required dynamic code,
  }) async {
    try {
      final data = {
        "code": code,
      };

      final response = await dio.post('/group-cards', data: data);

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
