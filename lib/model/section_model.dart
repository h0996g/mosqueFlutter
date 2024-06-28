class SectionModel {
  final String id;
  final String admin;
  final String photo;
  final String name;
  final String description;
  final List<LessonModel> lessons;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

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
      id: json['_id'] as String,
      admin: json['admin'] as String,
      photo: json['photo'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      lessons: (json['lesson'] as List)
          .map((lessonJson) => LessonModel.fromJson(lessonJson))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}

class LessonModel {
  final String id;
  final String section;
  final String title;
  final String photo;
  final String urlVideo;
  final String description;
  final List<dynamic> quize;
  final List<dynamic> comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  LessonModel({
    required this.id,
    required this.section,
    required this.title,
    required this.photo,
    required this.urlVideo,
    required this.description,
    required this.quize,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['_id'] as String,
      section: json['section'] as String,
      title: json['title'] as String,
      photo: json['photo'] as String,
      urlVideo: json['urlVideo'] as String,
      description: json['description'] as String,
      quize: json['quize'] as List<dynamic>,
      comments: json['commants'] as List<dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }
}
