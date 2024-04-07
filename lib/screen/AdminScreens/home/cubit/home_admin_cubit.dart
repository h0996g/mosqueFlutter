import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'package:mosque/screen/AdminScreens/annonce/annonce.dart';
import 'package:mosque/screen/AdminScreens/reservation/reservation.dart';
import 'dart:convert' as convert;

import 'package:mosque/screen/AdminScreens/terrains/terrains.dart';
import 'package:mosque/screen/AdminScreens/tournoi/tournoi.dart';

import '../../../../model/error_model copy.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit() : super(HomeAdminInitial());
  static HomeAdminCubit get(context) => BlocProvider.of(context);
  final List<Widget> body = [
    const Terrains(),
    const Reservation(),
    const Annonce(),
    const Tournoi()
  ];

  int selectedIndex = 0;
  void changeIndexNavBar(int index) {
    selectedIndex = index;
    emit(ChangeIndexNavBarState());
  }

  DataAdminModel? adminModel;

  setAdminModel(DataAdminModel adminModel) {
    this.adminModel = adminModel;
    emit(UpdateAdminModelVariable());
  }

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
