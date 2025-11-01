class GameModel {
  dynamic id;
  dynamic title;
  dynamic point;
  dynamic numChild;
  dynamic urlGame;

  GameModel();

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    point = json['point'];
    numChild = json['num_child'];
    urlGame = json['url_game'];
  }
}