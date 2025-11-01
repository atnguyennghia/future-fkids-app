class ProfileModel {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic age;
  dynamic grade;
  dynamic gender;
  int? typeAccount;
  dynamic avatar;
  dynamic birthday;
  int? provinceId;
  dynamic provinceName;
  dynamic className;

  ProfileModel();

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    age = json['age'];
    grade = json['class'];
    gender = json['gender'];
    typeAccount = json['type_account'];
    avatar = json['avatar'] == null || json['avatar'].toString().isEmpty
        ? null
        : json['avatar'];
    birthday = json['birthday'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    className = json['class_name'];
  }
}
