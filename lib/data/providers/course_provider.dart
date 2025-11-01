import 'package:dio/dio.dart';
import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/data/models/exercise_model.dart';
import 'package:futurekids/data/models/game_model.dart';
import 'package:futurekids/data/models/lesson_model.dart';
import 'package:futurekids/data/models/question_model.dart';
import 'package:futurekids/data/models/unit_model.dart';
import 'package:futurekids/data/models/vocabulary_model.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:futurekids/utils/config.dart';

class CourseProvider {
  final dio = Dio();

  CourseProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {'Accept': 'application/json'};
  }

  Future<List<BookModel>?> getListBook(
      {dynamic classId, dynamic subjectId}) async {
    try {
      final response =
          await dio.get('/books/list?class_id=$classId&subject_id=$subjectId');

      if (response.statusCode == 200) {
        return response.data['data']['books']
            .map<BookModel>((json) => BookModel.fromJson(json))
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

  Future<List<UnitModel>?> getListUnit({dynamic bookId}) async {
    try {
      final response = await dio.get(
          '/units/list?book_id=$bookId&profile_id=${AuthService.to.profileModel.value.id ?? ''}');

      if (response.statusCode == 200) {
        return response.data['data']['units']
            .map<UnitModel>((json) => UnitModel.fromJson(
                json,
                response.data['data']['is_actived'],
                response.data['data']['profile_units']))
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

  Future<List<LessonModel>?> getListLesson({dynamic unitId}) async {
    try {
      final response = await dio.get(
          '/lessons/list?unit_id=$unitId&profile_id=${AuthService.to.profileModel.value.id ?? ''}');

      if (response.statusCode == 200) {
        return response.data['data']['lessons']
            .map<LessonModel>((json) => LessonModel.fromJson(
                json,
                response.data['data']['is_actived'],
                response.data['data']['profile_lessons']))
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

  Future<List<CategoryModel>?> getListCategory({dynamic courseId}) async {
    try {
      final response = await dio.get(
          '/categories/list?course_id=$courseId&profile_id=${AuthService.to.profileModel.value.id ?? ''}');

      if (response.statusCode == 200) {
        return response.data['data']
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
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

  Future<dynamic> getContent(
      {required dynamic courseId,
      required dynamic categoryId,
      required dynamic categoryType}) async {
    try {
      final response = await dio.get(
          '/contents/list?course_id=$courseId&category_id=$categoryId&profile_id=${AuthService.to.profileModel.value.id ?? ''}');

      if (response.statusCode == 200) {
        switch (categoryType) {
          case 3:
            return response.data['data']['contents']
                .map<ExerciseModel>((json) => ExerciseModel.fromJson(
                    json, response.data['data']['profile_contents']))
                .toList();
          case 4:
            return response.data['data']['contents']
                .map<GameModel>((json) => GameModel.fromJson(json))
                .toList();
          case 6:
          case 7:
            return response.data['data']['contents']
                .map<VocabularyModel>((json) => VocabularyModel.fromJson(json))
                .toList();
        }
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

  Future<List<QuestionModel>?> getListQuestion({required dynamic exId}) async {
    try {
      final response =
          await dio.get('/contents/exercises/list?content_id=$exId');
      if (response.statusCode == 200) {
        return response.data['data']['contents']
            .map<QuestionModel>((json) => QuestionModel.fromJson(json))
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
}
