class UserModel {
  String? username;
  String? id;

  UserModel({this.username, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['id'] = id;
    return data;
  }
}
