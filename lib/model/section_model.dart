class SectionModel {
  String id;
  String admin;
  String photo;
  String name;
  String description;
  List<Lesson> lessons;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SectionModel({
    required this.id,
    required this.admin,
    required this.photo,
    required this.name,
    required this.description,
    required this.lessons,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['_id'],
      admin: json['admin'],
      photo: json['photo'],
      name: json['name'],
      description: json['description'],
      lessons: json['lesson'] is List<Lesson>
          ? json['lesson'].cast<Lesson>()
          : json['lesson'].map<Lesson>((id) => Lesson(id: id)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Lesson {
  String id;
  String? section;
  String? title;
  String? photo;
  String? urlVideo;
  String? description;
  List<dynamic>? quize;
  List<dynamic>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Lesson({
    required this.id,
    this.section,
    this.title,
    this.photo,
    this.urlVideo,
    this.description,
    this.quize,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'],
      section: json['section'],
      title: json['title'],
      photo: json['photo'],
      urlVideo: json['urlVideo'],
      description: json['description'],
      quize: json['quize'],
      comments: json['commants'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}
