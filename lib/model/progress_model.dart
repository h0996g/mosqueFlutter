class ProLesson {
  String id;
  String title;

  ProLesson({required this.id, required this.title});

  factory ProLesson.fromJson(Map<String, dynamic> json) {
    return ProLesson(
      id: json['_id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
    };
  }
}

class ProCompletedLesson {
  int score;
  ProLesson lesson;

  ProCompletedLesson({required this.score, required this.lesson});

  factory ProCompletedLesson.fromJson(Map<String, dynamic> json) {
    return ProCompletedLesson(
      score: json['score'],
      lesson: ProLesson.fromJson(json['_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      '_id': lesson.toJson(),
    };
  }
}

class ProSection {
  String id;
  String name;
  String description;

  ProSection({required this.id, required this.name, required this.description});

  factory ProSection.fromJson(Map<String, dynamic> json) {
    return ProSection(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
    };
  }
}

class ProDataModel {
  ProSection section;
  List<ProCompletedLesson> completedLessons;
  String id;

  ProDataModel(
      {required this.section,
      required this.completedLessons,
      required this.id});

  factory ProDataModel.fromJson(Map<String, dynamic> json) {
    var lessonsList = json['completedLessons'] as List;
    List<ProCompletedLesson> lessons =
        lessonsList.map((i) => ProCompletedLesson.fromJson(i)).toList();

    return ProDataModel(
      section: ProSection.fromJson(json['section']),
      completedLessons: lessons,
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'section': section.toJson(),
      'completedLessons':
          completedLessons.map((lesson) => lesson.toJson()).toList(),
      '_id': id,
    };
  }
}
