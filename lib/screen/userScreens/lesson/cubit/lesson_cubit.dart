import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/model/error_model.dart';
import 'package:mosque/model/section_model.dart';
import 'dart:convert' as convert;

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit() : super(LessonInitial());
  static LessonCubit get(context) => BlocProvider.of(context);
  String urlVideo = '';
  int indexLesson = 0;
  // SectionModel? sectionModel;
  Future<void> getSectionById({required String id}) async {
    emit(GetSectionByIdLoading());
    await Httplar.httpget(path: GETSECTIONBYID + id).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        SectionModel sectionModel = SectionModel.fromJson(jsonResponse);
        indexLesson = CachHelper.getData(key: sectionModel.id) ?? 0;
        urlVideo = getYoutubeVideoId(
            sectionModel.lessonObjects![indexLesson].urlVideo);
        print(urlVideo);
        emit(GetSectionByIdStateGood(model: sectionModel));

        // print(sectionModel.lessonObjects?.length);
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetSectionByIdStateBad());
    });
  }

  Future<void> changeUrlVideo({required String url}) async {
    urlVideo = url;
    emit(ChangeUrlVideoState());
  }

  void changeIndexLesson({required int index}) {
    indexLesson = index;
    emit(changeIndexLessonState());
  }

  Future<void> addCommentToLesson(
      {required String lessinId,
      required String comment,
      required String userID,
      required String onModel}) async {
    emit(AddCommentToLessonLoading());
    await Httplar.httpPut(path: ADDCOMMENTTOLESSON + lessinId, data: {
      "user": userID,
      "onModel": onModel,
      "comment": comment,
    }).then((value) {
      if (value.statusCode == 201) {
        emit(AddCommentToLessonStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
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
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetCommentsBad());
    });
  }

  String getYoutubeVideoId(String url) {
    String videoId = '';
    if (url.contains('youtube.com')) {
      videoId = url.split('v=')[1];
      if (videoId.contains('&')) {
        videoId = videoId.split('&')[0];
      }
    } else if (url.contains('youtu.be')) {
      videoId = url.split('.be/')[1];
    }
    return videoId;
  }
}
