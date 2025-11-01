class ProvinceModel {
  dynamic id;
  dynamic name;

  ProvinceModel();

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}