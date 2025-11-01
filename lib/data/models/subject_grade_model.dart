class SubjectGradeModel {
  dynamic subjectId;
  dynamic gradeId;
  dynamic name;
  dynamic image;

  SubjectGradeModel();

  SubjectGradeModel.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    gradeId = json['class_id'];
    name = json['name'];
    image = json['image'];
  }
}