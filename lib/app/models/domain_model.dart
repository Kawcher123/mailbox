class DomainModel {
  String? id;
  String? domain;
  bool? isActive;
  bool? isPrivate;
  String? createdAt;
  String? updatedAt;

  DomainModel(
      {this.id, this.domain, this.isActive, this.isPrivate, this.createdAt, this.updatedAt});

  DomainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domain = json['domain'];
    isActive = json['isActive'];
    isPrivate = json['isPrivate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['domain'] = domain;
    data['isActive'] = isActive;
    data['isPrivate'] = isPrivate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
