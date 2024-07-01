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
  Future<void> getSectionById({required String id}) async {
    emit(GetSectionByIdLoading());
    await Httplar.httpget(path: GETSECTIONBYID + id).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        SectionModel sectionModel = SectionModel.fromJson(jsonResponse);
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
}
