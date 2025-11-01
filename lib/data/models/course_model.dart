class CourseModel {
  dynamic courseId;
  dynamic lessonId;
  dynamic name;
  dynamic description;
  dynamic order;
  dynamic totalPoint;
  dynamic point = 0;
  dynamic percentComplete = 0;
  dynamic status = 2;
  dynamic image;

  CourseModel();

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    lessonId = json['lesson_id'];
    name = json['name'];
    description = json['description'];
    order = json['order'];
    totalPoint = json['total_point'];
    image = json['image'];
  }
}
