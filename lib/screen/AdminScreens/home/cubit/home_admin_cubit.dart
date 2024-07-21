import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'dart:convert' as convert;
import '../../../../model/error_model.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit() : super(HomeAdminInitial());
  static HomeAdminCubit get(context) => BlocProvider.of(context);

  void resetValue() {
    selectedIndex = 0;
    adminModel = null;
  }

  int selectedIndex = 0;
  void changeIndexNavBar(int index) {
    selectedIndex = index;
    emit(ChangeIndexNavBarState());
  }

  DataAdminModel? adminModel;
  Future<void> getMyInfo() async {
    emit(GetMyInformationLoading());
    await Httplar.httpget(path: GETMYINFORMATIONADMIN).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        adminModel = DataAdminModel.fromJson(jsonResponse);
        emit(GetMyInformationStateGood(model: adminModel!));
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorHomeState(model: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyInformationStateBad());
    });
  }
}
