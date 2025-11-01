class CardModel {
  dynamic email;
  dynamic className;
  dynamic subjectName;
  dynamic activeAt;
  dynamic expireAt;
  dynamic code;
  dynamic cardName;
  dynamic cardType;

  CardModel();

  CardModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    className = json['class_name'];
    subjectName = json['subject_name'];
    activeAt = json['actived_at'].toString().split(' ')[0];
    expireAt = json['expired_at'];
    code = json['code'];
    cardName = json['card_name'];
    cardType = json['card_type'] == 1
        ? 'Thẻ cơ bản'
        : json['card_type'] == 2
            ? 'Thẻ VIP'
            : 'Thẻ Plus';
  }
}
