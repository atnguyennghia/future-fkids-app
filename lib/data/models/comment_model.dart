class CommentModel {
  int? videoId;
  String? driverFileId;
  String? driverFileLink;
  _Comment? comment;

  CommentModel();

  CommentModel.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    driverFileId = json['driver_file_id'];
    driverFileLink = json['driver_file_link'];
    comment = _Comment.fromJson(json['comment']);
  }
}

class _Comment {
  String? comment;
  String? type;
  DateTime? time;
  int? adminId;
  String? avatar;
  String? name;

  _Comment();

  _Comment.fromJson(Map<String, dynamic> json) {}
}
