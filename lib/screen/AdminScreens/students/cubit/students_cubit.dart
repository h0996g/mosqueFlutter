import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model.dart';
import 'dart:convert' as convert;

import 'package:mosque/model/user_model.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsInitial());
  static StudentsCubit get(context) => BlocProvider.of(context);
  Future<void> getStudents() async {
    emit(GetStudentsLoading());
    try {
      await Httplar.httpget(path: GETALLSTUDENTS).then((value) {
        if (value.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(value.body) as List;
          List<DataUserModel> students = jsonResponse
              .map((e) => DataUserModel.fromJson(e as Map<String, dynamic>))
              .toList();
          emit(GetStudentsGood(students: students));
        } else if (value.statusCode == 401) {
          var jsonResponse =
              convert.jsonDecode(value.body) as Map<String, dynamic>;
          emit(StudentsError(model: ErrorModel.fromJson(jsonResponse)));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(GetStudentsBad());
    }
  }
}
