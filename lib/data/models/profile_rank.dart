class ProfileRankModel {
  dynamic rank;
  List<ProfileRankDetail> listRanks = [];
  ProfileRankDetail? profileRank;

  ProfileRankModel();

  ProfileRankModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    if (json['lists'] != null) {
      listRanks = json['lists']
          .map<ProfileRankDetail>((e) => ProfileRankDetail.fromJson(e))
          .toList();
    }
    if (json['profile'] != null) {
      profileRank = ProfileRankDetail.fromJson(json['profile']);
    }
  }
}

class ProfileRankDetail {
  dynamic profileId;
  String? profileName;
  String? profileAvatar;
  double? totalPoint;
  int? places;

  ProfileRankDetail();

  ProfileRankDetail.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    profileName = json['profile_name'];
    profileAvatar = json['profile_avatar'];
    totalPoint = double.tryParse(json['total_point'].toString());
    places = json['places'];
  }
}
