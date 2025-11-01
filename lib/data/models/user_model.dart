import 'package:futurekids/data/models/profile_model.dart';

class UserModel {
  dynamic id;
  dynamic email;
  dynamic mobile;
  dynamic status;
  dynamic emailVerifiedAt;
  List<ProfileModel>? profile;

  UserModel({this.id, this.email, this.mobile, this.status, this.emailVerifiedAt, this.profile});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    profile = json['profile'].map<ProfileModel>((e) => ProfileModel.fromJson(e)).toList();
  }
}