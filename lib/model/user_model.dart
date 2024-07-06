class UserModel {
  bool? status;
  String? success;
  String? token;
  DataUserModel? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    token = json['token'];
    data = DataUserModel.fromJson(json['data']);
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

class DataUserModel {
  DataUserModel({
    this.id,
    this.username,
    this.nom,
    this.prenom,
    this.email,
    this.telephone,
    this.age,
    this.photo,
    this.commants,
    this.sectionProgress,
    this.createdAt,
    this.updatedAt,
    // required this._V,
  });

  String? id;
  String? username;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  int? age;
  String? photo;
  List<dynamic>? commants;
  List<SectionProgress>? sectionProgress;

  String? createdAt;
  String? updatedAt;

  DataUserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    age = json['age'];
    photo = json['photo'];
    commants = json['commants'];
    if (json['sectionProgress'] != null) {
      sectionProgress = <SectionProgress>[];
      json['sectionProgress'].forEach((v) {
        sectionProgress!.add(SectionProgress.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    // _data['username'] = username;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['email'] = email;
    _data['telephone'] = telephone;
    _data['age'] = age;

    _data['photo'] = photo;
    _data['commants'] = commants;
    if (sectionProgress != null) {
      _data['sectionProgress'] =
          sectionProgress!.map((v) => v.toJson()).toList();
    }
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class SectionProgress {
  String? section;
  List<CompletedLesson>? completedLessons;
  String? id;

  SectionProgress({this.section, this.completedLessons, this.id});

  SectionProgress.fromJson(Map<String, dynamic> json) {
    section = json['section'];
    if (json['completedLessons'] != null) {
      completedLessons = <CompletedLesson>[];
      json['completedLessons'].forEach((v) {
        completedLessons!.add(CompletedLesson.fromJson(v));
      });
    }
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['section'] = section;
    if (completedLessons != null) {
      data['completedLessons'] =
          completedLessons!.map((v) => v.toJson()).toList();
    }
    data['_id'] = id;
    return data;
  }
}

class CompletedLesson {
  int? score;
  String? id;

  CompletedLesson({this.score, this.id});

  CompletedLesson.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score;
    data['_id'] = id;
    return data;
  }
}
