class AdminModel {
  bool? status;
  String? success;
  String? token;
  DataAdminModel? data;

  AdminModel({
    this.status,
    this.success,
    this.token,
    this.data,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      status: json['status'],
      success: json['success'],
      token: json['token'],
      data: json['data'] != null ? DataAdminModel.fromJson(json['data']) : null,
    );
  }
}

class DataAdminModel {
  String? id;
  String? username;
  String? nom;
  String? prenom;
  String? email;
  int? age;
  String? photo;
  String? telephone;
  List<dynamic>? commants;

  String? createdAt;
  String? updatedAt;
  int? v;

  DataAdminModel({
    this.id,
    this.username,
    this.nom,
    this.prenom,
    this.email,
    this.photo,
    this.telephone,
    this.commants,
    this.age,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DataAdminModel.fromJson(Map<String, dynamic> json) {
    return DataAdminModel(
      id: json['_id'],
      username: json['username'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      photo: json['photo'],
      age: json['age'],
      telephone: json['telephone'],
      commants: json['commants'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
