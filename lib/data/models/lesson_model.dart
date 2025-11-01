import 'package:futurekids/data/models/course_model.dart';

class LessonModel {
  dynamic lessonId;
  dynamic unitId;
  dynamic name;
  dynamic description;
  dynamic order;
  dynamic totalPoint;
  dynamic point = 0;
  dynamic isLock;
  dynamic percentComplete = 0;
  bool? isExpanded = false;
  dynamic status = 2;
  List<CourseModel> courses = [];
  dynamic cardLevel = 0;

  LessonModel();

  LessonModel.fromJson(Map<String, dynamic> json, dynamic isActive,
      List<dynamic> profileLessons) {
    lessonId = json['lesson_id'];
    unitId = json['unit_id'];
    name = json['name'];
    description = json['description'];
    order = json['order'];
    totalPoint = json['total_point'];

    cardLevel = isActive;

    isLock = isActive >= 1 ? 0 : json['paid_status'];

    if (json['courses'] != null) {
      courses = json['courses']
          .map<CourseModel>((e) => CourseModel.fromJson(e))
          .toList();
    }

    for (var element in profileLessons) {
      if (element['lesson_id'] == json['lesson_id']) {
        point = element['point'];
        percentComplete = element['percent_complete'];
        status = element['status'];
        isExpanded = status == 0;

        for (var courseMap in element['courses']) {
          for (var courseObj in courses) {
            if (courseMap['course_id'].toString() ==
                courseObj.courseId.toString()) {
              courseObj.point = courseMap['point'];
              courseObj.percentComplete = courseMap['percent_complete'];
              courseObj.status = courseMap['status'];
              break;
            }
          }
        }

        break;
      }
    }
  }
}
