import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/Api/constApi.dart';
import 'dart:convert' as convert;

import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'package:mosque/Model/user_model.dart';
import 'package:mosque/model/error_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Icon iconhidden = const Icon(Icons.visibility_outlined);
  bool ishidden = true;
  bool checkBox = false;
  void changeCheckBox() {
    checkBox = !checkBox;
    emit(CheckBoxState());
  }

  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off_outlined);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility_outlined);
      ishidden = !ishidden;
    }
    emit(PasswordHiddenState());
  }

  void registerUser({required Map<String, dynamic> data}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: REGISTERJOUER, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(RegisterStateGood(model: UserModel.fromJson(jsonResponse)));
      } else if (value.statusCode == 400) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }

  void login({required Map<String, dynamic> data, required String path}) {
    emit(LoginLoadingState());
    Httplar.httpPost(path: path, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        if (path == Loginadmin) {
          emit(LoginStateGood(model: AdminModel.fromJson(jsonResponse)));
        } else if (path == Loginuser) {
          emit(LoginStateGood(model: UserModel.fromJson(jsonResponse)));
        }
      } else if (value.statusCode == 400 ||
          value.statusCode == 401 ||
          value.statusCode == 404) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        emit(ErrorState(errorModel: ErrorModel.fromJson(jsonResponse)));
      }
    }).catchError((e) {
      print(e.toString());
      emit(LoginStateBad());
    });
  }

  Map<String, bool> isHidden = {
    "pass": true,
    "pass1": true,
  };
  void togglePasswordVisibility(String fieldKey) {
    isHidden[fieldKey] = !isHidden[fieldKey]!;
    emit(PasswordVisibilityChanged());
  }
}
