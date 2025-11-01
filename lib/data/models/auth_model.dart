class AuthModel {
  dynamic accessToken;
  dynamic tokenType;
  dynamic expiresAt;

  AuthModel({this.accessToken, this.tokenType, this.expiresAt});

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_at'] = expiresAt;
    return data;
  }
}