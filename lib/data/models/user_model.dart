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
    profile = json['profile'] != null
        ? (json['profile'] as List).map<ProfileModel>((e) => ProfileModel.fromJson(e)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['email_verified_at'] = emailVerifiedAt;
    data['profile'] = profile?.map((e) => e.toJson()).toList();
    return data;
  }
}