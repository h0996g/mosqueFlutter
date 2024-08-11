import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/model/error_model.dart';
import 'package:mosque/model/section_model.dart';
import 'dart:convert' as convert;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
part 'lesson_state.dart';

class LessonAdminCubit extends Cubit<LessonAdminState> {
  LessonAdminCubit() : super(LessonInitial());
  static LessonAdminCubit get(context) => BlocProvider.of(context);
  void resetValues() {
    urlVideo = '';
    indexLesson = 0;
    newCommentId = '';
  }

  String urlVideo = '';
  int indexLesson = 0;
// hatit.ha fl cubit hada 3la khater fl 7a9 tjib lesson kml t3 section
  Future<void> getSectionById({required String id}) async {
    emit(GetSectionByIdLoading());
    await Httplar.httpget(path: GETSECTIONBYID + id).then((value) async {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        SectionModel sectionModel = SectionModel.fromJson(jsonResponse);
        if (sectionModel.lessonObjects!.isEmpty) {
          emit(GetSectionByIdStateGood(model: sectionModel));
          return;
        }

        indexLesson = CachHelper.getData(key: '${sectionModel.id!}admin') ?? 0;
        urlVideo = getYoutubeVideoId(
            sectionModel.lessonObjects![indexLesson].urlVideo ?? '');
        await Future.delayed(const Duration(milliseconds: 300));
        emit(GetSectionByIdStateGood(model: sectionModel));

        // print(sectionModel.lessonObjects?.length);
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetSectionByIdStateBad());
    });
  }

  void changeIndexLesson({required int index}) {
    indexLesson = index;
    emit(ChangeIndexLessonState());
  }

  String? newCommentId;
  Future<void> addCommentToLesson(
      {required String lessinId,
      required String comment,
      required String userID,
      required String onModel}) async {
    emit(AddCommentToLessonLoading());
    await Httplar.httpPost(path: ADDCOMMENTTOLESSON + lessinId, data: {
      "user": userID,
      "onModel": onModel,
      "comment": comment,
    }).then((value) {
      if (value.statusCode == 201) {
        newCommentId = convert.jsonDecode(value.body);
        emit(AddCommentToLessonStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(AddCommentToLessonStateBad());
    });
  }

  Future<void> getComments({required lessonID}) async {
    emit(GetCommentsLoading());
    await Httplar.httpget(path: GETCOMMENTS + lessonID).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        List<Comment> comments =
            jsonResponse.map((e) => Comment.fromJson(e)).toList();

        emit(GetCommentsGood(comments: comments));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(GetCommentsBad());
    });
  }

  Future<void> getQuiz({required lessonID}) async {
    emit(GetQuizLoading());
    await Httplar.httpget(path: GETQUIZ + lessonID).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        List<Quiz> quiz = jsonResponse.map((e) => Quiz.fromJson(e)).toList();

        emit(GetQuizGood(quiz: quiz));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(GetQuizBad());
    });
  }

  Future<void> deleteComment(
      {required String lessonID, required String commentID}) async {
    emit(DeleteCommentLoading());
    await Httplar.httpPut(
        path: DELETECOMMENT + lessonID,
        data: {'commentId': commentID}).then((value) {
      if (value.statusCode == 200) {
        emit(DeleteCommentGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(DeleteCommentBad());
    });
  }

  String? linkPdfFile;
  Future<void> uploadPdfFile(File pdfFile, {String? oldPdfUrl}) async {
    await deleteOldPdfFirebase(deleteOldPdfUrl: oldPdfUrl);
    String fileName = path.basename(pdfFile.path);
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('pdf/$fileName')
        .putFile(pdfFile)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        linkPdfFile = value;
      }).catchError((e) {
        emit(UploadPdfFileAndGetUrlStateBad());
      });
    });
  }

  Future<void> updateLesson(
      {required String lessonId,
      required Map<String, dynamic> data,
      required File? pdfFile,
      String? oldPdfUrl,
      required bool isJustremovePdf}) async {
    emit(UpdateLessonLoading());
    if (isJustremovePdf) {
      data['suplemmentPdf'] = null;
      await deleteOldPdfFirebase(deleteOldPdfUrl: oldPdfUrl);
    }
    if (pdfFile != null) {
      await uploadPdfFile(pdfFile, oldPdfUrl: oldPdfUrl);
    }
    if (linkPdfFile != null) {
      data['suplemmentPdf'] = linkPdfFile;
      linkPdfFile = null;
    }

    await Httplar.httpPut(path: UPDATELESSON + lessonId, data: data)
        .then((value) {
      if (value.statusCode == 200) {
        emit(UpdateLessonGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(UpdateLessonBad());
    });
  }

  Future<void> updateQuiz(
      {required String lessonId, required List<Quiz> quiz}) async {
    emit(UpdateQuizLoading());
    await Httplar.httpPut(path: UPDATEQUIZ + lessonId, data: {'quiz': quiz})
        .then((value) {
      if (value.statusCode == 200) {
        emit(UpdateQuizGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(UpdateQuizBad());
    });
  }

  Future<void> createLesson(
      {required Map<String, dynamic> data, required File? pdfFile}) async {
    emit(CreateLessonLoading());
    if (pdfFile != null) {
      await uploadPdfFile(pdfFile);
    }
    if (linkPdfFile != null) {
      data['suplemmentPdf'] = linkPdfFile;
      linkPdfFile = null;
    }
    Httplar.httpPost(path: CREATELESSON, data: data).then((value) {
      if (value.statusCode == 201) {
        emit(CreateLessonGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      emit(CreateLessonBad());
    });
  }

  Future<void> deleteLesson(
      {required String lessonID, required String? oldPdfUrl}) async {
    emit(DeleteLessonLoading());
    await Httplar.httpdelete(path: DELETELESSON + lessonID).then((value) async {
      if (value.statusCode == 204) {
        emit(DeleteLessonGood(oldPdfUrl: oldPdfUrl));
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: errorModel));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteLessonBad());
    });
  }

  Future<void> deleteOldPdfFirebase({required String? deleteOldPdfUrl}) async {
    if (deleteOldPdfUrl != null) {
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(deleteOldPdfUrl)
          .delete()
          .then((_) {
        print('Old Pdf deleted successfully');
      }).catchError((error) {
        print('Failed to delete old Pdf: $error');
      });
    }
  }
}
