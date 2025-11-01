import 'package:futurekids/data/models/rank_model.dart';

class AchievementModel {
  AchievementDetail? total;
  List<AchievementDetail> statistics = [];

  AchievementModel();

  AchievementModel.fromJson(
      Map<String, dynamic> json, dynamic classId, dynamic profileId) {
    if (!json['total'].isEmpty) {
      total = AchievementDetail.fromJson(json['total'][0]);
    } else {
      total = AchievementDetail();
    }

    statistics.add(AchievementDetail(
        subjectId: 1, classId: classId, profileId: profileId));
    statistics.add(AchievementDetail(
        subjectId: 2, classId: classId, profileId: profileId));
    statistics.add(AchievementDetail(
        subjectId: 3, classId: classId, profileId: profileId));

    for (int i = 0; i < statistics.length; i++) {
      for (var item in json['statistics']) {
        if (item['subject_id'] == statistics[i].subjectId) {
          statistics[i] = AchievementDetail.fromJson(item);
        }
      }
    }

    statistics.sort((a, b) => -a.rankId.compareTo(b.rankId));
  }
}

class AchievementDetail {
  dynamic profileId;
  dynamic subjectId;
  dynamic classId;
  dynamic rankId;
  dynamic totalPoint;
  dynamic amountDiamond;
  List<RankModel> ranks = [];

  AchievementDetail(
      {this.profileId,
      this.subjectId,
      this.classId,
      this.rankId = 0,
      this.totalPoint = 0,
      this.amountDiamond = 0});

  AchievementDetail.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    subjectId = json['subject_id'];
    classId = json['class_id'];
    rankId = json['rank_id'];
    totalPoint = json['total_point'];
    amountDiamond = json['amount_diamond'];
    for (var item in json['ranks']) {
      ranks.add(RankModel.fromJson(item));
    }
    ranks.insert(
        0,
        RankModel()
          ..rankId = 0
          ..minPoint = 0);
  }
}
