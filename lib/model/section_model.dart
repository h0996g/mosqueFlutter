// class SectionModel {
//   final String id;
//   final String admin;
//   final String photo;
//   final String name;
//   final String description;
//   final List<Lesson>? lessonObjects;
//   final List<String>? lessonIds;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   SectionModel({
//     required this.id,
//     required this.admin,
//     required this.photo,
//     required this.name,
//     required this.description,
//     this.lessonObjects,
//     this.lessonIds,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory SectionModel.fromJson(Map<String, dynamic> json) {
//     List<Lesson>? lessonObjects;
//     List<String>? lessonIds;

//     if (json['lesson'] is List) {
//       if (json['lesson'].isNotEmpty &&
//           json['lesson'][0] is Map<String, dynamic>) {
//         lessonObjects = (json['lesson'] as List)
//             .map((lessonJson) => Lesson.fromJson(lessonJson))
//             .toList();
//       } else if (json['lesson'].isNotEmpty && json['lesson'][0] is String) {
//         lessonIds = json['lesson'].cast<String>();
//       }
//     }

//     return SectionModel(
//       id: json['_id'],
//       admin: json['admin'],
//       photo: json['photo'],
//       name: json['name'],
//       description: json['description'],
//       lessonObjects: lessonObjects,
//       lessonIds: lessonIds,
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       v: json['__v'],
//     );
//   }
// }

// class Lesson {
//   final String id;
//   final String section;
//   final String title;
//   final String photo;
//   final String urlVideo;
//   final String description;
//   final String? suplemmentPdf;
//   final String duration;
//   final List<Quiz> quize;
//   final List<Comment> comments;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   Lesson({
//     required this.id,
//     required this.section,
//     required this.title,
//     required this.photo,
//     required this.urlVideo,
//     required this.description,
//     this.suplemmentPdf,
//     required this.duration,
//     required this.quize,
//     required this.comments,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory Lesson.fromJson(Map<String, dynamic> json) {
//     var quizeFromJson = json['quize'] as List;
//     List<Quiz> quizeList =
//         quizeFromJson.map((quizJson) => Quiz.fromJson(quizJson)).toList();
//     var commentsFromJson = json['comments'] as List;
//     List<Comment> commentsList = commentsFromJson
//         .map((commentJson) => Comment.fromJson(commentJson))
//         .toList();
//     return Lesson(
//       id: json['_id'],
//       section: json['section'],
//       title: json['title'],
//       photo: json['photo'],
//       urlVideo: json['urlVideo'],
//       description: json['description'],
//       suplemmentPdf: json['suplemmentPdf'],
//       duration: json['duration'],
//       quize: quizeList,
//       comments: commentsList,
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       v: json['__v'],
//     );
//   }
// }

// class Quiz {
//   final String question;
//   final List<int> correctAnswerIndex;
//   final List<String> options;
//   final String id;

//   Quiz({
//     required this.question,
//     required this.correctAnswerIndex,
//     required this.options,
//     required this.id,
//   });

//   factory Quiz.fromJson(Map<String, dynamic> json) {
//     return Quiz(
//       question: json['question'],
//       correctAnswerIndex: List<int>.from(json['correctAnswerIndex']),
//       options: List<String>.from(json['options']),
//       id: json['_id'],
//     );
//   }
// }

// class Comment {
//   final String user;
//   final String onModel;
//   final String comment;
//   // final String id;

//   Comment({
//     required this.user,
//     required this.onModel,
//     required this.comment,
//     // required this.id,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) {
//     return Comment(
//       user: json['user'] as String,
//       onModel: json['onModel'] as String,
//       comment: json['comment'] as String,
//       // id: json['_id'] as String,
//     );
//   }
// }

class SectionModel {
  final String? id;
  final String? admin;
  final String? photo;
  final String? name;
  final String? description;
  final List<Lesson>? lessonObjects;
  final List<String>? lessonIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  SectionModel({
    this.id,
    this.admin,
    this.photo,
    this.name,
    this.description,
    this.lessonObjects,
    this.lessonIds,
    this.createdAt,
    this.updatedAt,
    this.v,
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
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class Lesson {
  final String? id;
  final String? section;
  final String? title;
  final String? photo;
  final String? urlVideo;
  final String? description;
  final String? suplemmentPdf;
  final String? duration;
  final List<Quiz>? quize;
  final List<Comment>? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Lesson({
    this.id,
    this.section,
    this.title,
    this.photo,
    this.urlVideo,
    this.description,
    this.suplemmentPdf,
    this.duration,
    this.quize,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var quizeFromJson = json['quize'] as List?;
    List<Quiz>? quizeList =
        quizeFromJson?.map((quizJson) => Quiz.fromJson(quizJson)).toList();

    var commentsFromJson = json['comments'] as List?;
    List<Comment>? commentsList = commentsFromJson
        ?.map((commentJson) => Comment.fromJson(commentJson))
        .toList();

    return Lesson(
      id: json['_id'],
      section: json['section'],
      title: json['title'],
      photo: json['photo'],
      urlVideo: json['urlVideo'],
      description: json['description'],
      suplemmentPdf: json['suplemmentPdf'],
      duration: json['duration'],
      quize: quizeList,
      comments: commentsList,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class Quiz {
  final String? question;
  final List<int>? correctAnswerIndex;
  final List<String>? options;
  final String? id;

  Quiz({
    this.question,
    this.correctAnswerIndex,
    this.options,
    this.id,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'],
      correctAnswerIndex: json['correctAnswerIndex'] != null
          ? List<int>.from(json['correctAnswerIndex'])
          : null,
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      id: json['_id'],
    );
  }
}

class Comment {
  final User? user;
  final String? onModel;
  final String? comment;
  final String? id;
  final bool? isDeleted;
  final String? createdAt;

  Comment({
    this.user,
    this.onModel,
    this.comment,
    this.isDeleted,
    this.createdAt,
    this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      onModel: json['onModel'],
      comment: json['comment'],
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'],
      id: json['_id'],
    );
  }
}

class User {
  final String? id;
  final String? username;
  final String? photo;

  User({
    this.id,
    this.username,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      photo: json['photo'],
    );
  }
}
