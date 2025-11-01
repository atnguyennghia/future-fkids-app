class RankModel {
  dynamic rankId;
  dynamic minPoint;
  dynamic maxPoint;

  RankModel();

  RankModel.fromJson(Map<String, dynamic> json) {
    rankId = json['rank_id'];
    minPoint = json['min_point'];
    maxPoint = json['max_point'];
  }
}
