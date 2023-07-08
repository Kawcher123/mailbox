class LoginModel {
  int? code;
  String? token;
  String? id;
  String? message;

  LoginModel({this.code, this.token, this.id, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    token = json['token'];
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['token'] = token;
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}