import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'dart:convert' as convert;

import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model.dart';
import 'package:mosque/model/section_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get(context) => BlocProvider.of(context);

  Future<void> getAllSection() async {
    List<SectionModel> sectionModel = [];
    emit(GetAllSectionLoading());
    await Httplar.httpget(path: GETALLSECTION).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(value.body) as List;
        sectionModel =
            jsonResponse.map((e) => SectionModel.fromJson(e)).toList();
        emit(GetAllSectionStateGood(model: sectionModel));

        print(sectionModel.first.name);
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetAllSectionStateBad());
    });
  }

  Future<void> deleteSection(
      {required String sectionId, required String mot_de_passe}) async {
    emit(DeleteSectionLoading());
    await Httplar.httpPost(
        path: DELETESECTION + sectionId,
        data: {"mot_de_passe": mot_de_passe}).then((value) {
      if (value.statusCode == 204) {
        emit(DeleteSectionGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(jsonResponse);
        ErrorModel errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorCategoryState(model: errorModel));
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteSectionBad());
    });
  }
}
