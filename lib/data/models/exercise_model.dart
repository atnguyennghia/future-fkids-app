class ExerciseModel {
  dynamic id;
  dynamic title;
  dynamic type;
  dynamic totalPoint;
  dynamic numChild;
  dynamic point = 0;
  dynamic percentComplete = 0;
  dynamic status = 2;

  ExerciseModel();

  ExerciseModel.fromJson(
      Map<String, dynamic> json, List<dynamic> profileContents) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    totalPoint = json['point'];
    numChild = json['num_child'];

    for (var element in profileContents) {
      if (element['content_id'] == json['id']) {
        point = element['point'];
        percentComplete = element['percent_complete'];
        status = element['status'];
      }
    }
  }
}
