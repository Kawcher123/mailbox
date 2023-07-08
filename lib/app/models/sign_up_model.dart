class SignUpModel {
  String? id;
  String? detail;

  SignUpModel({this.id, this.detail});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['detail'] = detail;
    return data;
  }
}