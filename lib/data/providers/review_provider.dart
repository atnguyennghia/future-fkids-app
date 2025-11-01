import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/auth_service.dart';
import '../../utils/config.dart';

class ReviewProvider {
  final dio = Dio();

  ReviewProvider() {
    dio.options.baseUrl = kBaseUrl;
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AuthService.to.authModel?.accessToken}'
    };
  }

  Future<dynamic> uploadVideo(
      {required dynamic courseId,
      required dynamic categoryId,
      required dynamic contentId,
      required XFile video,
      required Function(int count, int total) onSendProgress}) async {
    try {
      final data = {
        "profile_id": AuthService.to.profileModel.value.id,
        "course_id": courseId,
        "category_id": categoryId,
        "content_id": contentId,
        "video": MultipartFile.fromBytes(await video.readAsBytes(),
            filename: video.name)
      };
      final response = await dio.post('/synthetic/video',
          data: FormData.fromMap(data), onSendProgress: onSendProgress);

      if (response.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw e.response?.data['message'];
      }
      if (e.type == DioErrorType.response) {
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<dynamic> getComment(
      {required dynamic courseId,
      required dynamic categoryId,
      required dynamic contentId}) async {
    try {
      final data = {
        "profile_id": AuthService.to.profileModel.value.id,
        "course_id": courseId,
        "category_id": categoryId,
        "content_id": contentId,
      };
      final response = await dio.get('/synthetic', queryParameters: data);

      if (response.statusCode == 200) {
        return response.data['data'];
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw e.response?.data['message'];
      }
      if (e.type == DioErrorType.response) {
        throw e.message;
      }
    } catch (e) {
      throw e.toString();
    }
    return null;
  }
}
