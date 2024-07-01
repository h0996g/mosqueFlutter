class SectionModel {
  final String id;
  final String admin;
  final String photo;
  final String name;
  final String description;
  final List<Lesson>? lessonObjects;
  final List<String>? lessonIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SectionModel({
    required this.id,
    required this.admin,
    required this.photo,
    required this.name,
    required this.description,
    this.lessonObjects,
    this.lessonIds,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    List<Lesson>? lessonObjects;
    List<String>? lessonIds;

    if (json['lesson'] is List) {
      if (json['lesson'].isNotEmpty &&
          json['lesson'][0] is Map<String, dynamic>) {
        lessonObjects = (json['lesson'] as List)
            .map((lessonJson) => Lesson.fromJson(lessonJson))
            .toList();
      } else if (json['lesson'].isNotEmpty && json['lesson'][0] is String) {
        lessonIds = json['lesson'].cast<String>();
      }
    }

    return SectionModel(
      id: json['_id'],
      admin: json['admin'],
      photo: json['photo'],
      name: json['name'],
      description: json['description'],
      lessonObjects: lessonObjects,
      lessonIds: lessonIds,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Lesson {
  final String id;
  final String section;
  final String title;
  final String photo;
  final String urlVideo;
  final String description;
  final String duration;
  final List<dynamic> quize;
  final List<dynamic> commants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Lesson({
    required this.id,
    required this.section,
    required this.title,
    required this.photo,
    required this.urlVideo,
    required this.description,
    required this.duration,
    required this.quize,
    required this.commants,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'],
      section: json['section'],
      title: json['title'],
      photo: json['photo'],
      urlVideo: json['urlVideo'],
      description: json['description'],
      duration: json['duration'],
      quize: json['quize'],
      commants: json['commants'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
