import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
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
        urlVideo = sectionModel.lessonObjects!.first.urlVideo;
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

  // Future<void> updateLessonCompletionStatus(
  //     {required String idlesson,
  //     required String idSection,
  //     required int score}) async {
  //   emit(UpdateLessonCompletionStatusLoading());
  //   await Httplar.httpPost(path: COMPLETLESSONPROGRESS, data: {
  //     "lessonId": idlesson,
  //     "score": score,
  //     "sectionId": idSection
  //   }).then((value) {
  //     if (value.statusCode == 200) {
  //       emit(UpdateLessonCompletionStateGood());
  //     } else {
  //       var jsonResponse =
  //           convert.jsonDecode(value.body) as Map<String, dynamic>;
  //       ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
  //       print(error_model.message);
  //       emit(ErrorState(model: error_model));
  //     }
  //   }).catchError((e) {
  //     print(e.toString());
  //     emit(UpdateLessonCompletionStateBad());
  //   });
  // }
}
