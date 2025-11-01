class BookModel {
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic status;
  int? subjectId;
  dynamic classId;
  dynamic image;

  BookModel(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.subjectId,
      this.classId,
      this.image});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    subjectId = json['subject_id'];
    classId = json['class_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['subject_id'] = subjectId;
    data['class_id'] = classId;
    data['image'] = image;
    return data;
  }
}
