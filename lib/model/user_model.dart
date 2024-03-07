class UserModel {
  bool? status;
  String? success;
  String? token;
  Data? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    token = json['token'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['success'] = success;
    _data['token'] = token;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  String? id;
  String? nom;
  String? prenom;
  String? email;
  int? telephone;
  int? age;
  String? photo;
  List<dynamic>? commants;
  String? createdAt;
  String? updatedAt;
  int? _V;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    age = json['age'];
    photo = json['photo'];
    commants = List.castFrom<dynamic, dynamic>(json['commants']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['email'] = email;
    _data['telephone'] = telephone;
    _data['age'] = age;
    _data['photo'] = photo;
    _data['commants'] = commants;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = _V;
    return _data;
  }
}
