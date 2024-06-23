import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'dart:convert' as convert;

import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/user_model.dart';
import 'package:mosque/model/error_model.dart';

part 'home_user_state.dart';

class HomeUserCubit extends Cubit<HomeUserState> {
  HomeUserCubit() : super(HomeUserInitial());
  static HomeUserCubit get(context) => BlocProvider.of(context);

  DataUserModel? userDataModel;

  Future<void> getMyInfo() async {
    emit(GetMyInformationLoading());
    await Httplar.httpget(path: GETMYINFORMATIONJOUEUR).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        userDataModel = DataUserModel.fromJson(jsonResponse);
        emit(GetMyInformationStateGood(model: userDataModel!));
      } else if (value.statusCode == 401) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetMyInformationStateBad());
    });
  }
}
