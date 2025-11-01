import 'package:dio/dio.dart';
import 'package:futurekids/data/models/grade_model.dart';
import 'package:futurekids/data/models/subject_grade_model.dart';
import 'package:futurekids/utils/config.dart';

class GradeProvider {
  final dio = Dio();

  GradeProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept' : 'application/json'
    };
  }

  Future<List<GradeModel>?> getListGrade() async {
    try {
      final response = await dio.get('/class/list');

      if (response.statusCode == 200) {
        return response.data['data'].map<GradeModel>((json) => GradeModel.fromJson(json)).toList();
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

  Future<List<SubjectGradeModel>?> getListGradeBySubject({required subjectId}) async {
    try {
      final response = await dio.get('/class/detail?subject_id=$subjectId');

      if (response.statusCode == 200) {
        return response.data['data'].map<SubjectGradeModel>((json) => SubjectGradeModel.fromJson(json)).toList();
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