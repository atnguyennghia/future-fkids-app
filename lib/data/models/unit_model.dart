class UnitModel {
  dynamic unitId;
  dynamic name;
  dynamic description;
  dynamic order;
  dynamic bookId;
  dynamic totalPoint;
  dynamic point = 0;
  dynamic isLock;
  dynamic percentComplete = 0;
  dynamic status = 2;

  UnitModel(
      {this.unitId,
      this.name,
      this.description,
      this.order,
      this.bookId,
      this.totalPoint,
      this.point,
      this.isLock,
      this.percentComplete});

  UnitModel.fromJson(
      Map<String, dynamic> json, dynamic isActive, List<dynamic> profileUnit) {
    unitId = json['unit_id'];
    name = json['name'];
    description = json['description'];
    order = json['order'];
    bookId = json['book_id'];
    totalPoint = json['total_point'];

    isLock = isActive >= 1 ? 0 : json['paid_status'];

    for (var element in profileUnit) {
      if (element['unit_id'] == json['unit_id']) {
        point = element['point'];
        percentComplete = element['percent_complete'];
        status = element['status'];
        break;
      }
    }
  }
}
