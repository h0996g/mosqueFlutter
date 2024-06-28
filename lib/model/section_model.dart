class SectionModel {
  final String id;
  final String admin;
  final String photo;
  final String name;
  final String description;
  final List<String> lesson;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SectionModel({
    required this.id,
    required this.admin,
    required this.photo,
    required this.name,
    required this.description,
    required this.lesson,
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
      lesson:
          (json['lesson'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'admin': admin,
      'photo': photo,
      'name': name,
      'description': description,
      'lesson': lesson,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
