import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model.dart';
import 'package:mosque/model/user_model.dart';
import 'dart:convert' as convert;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  Icon iconhidden = const Icon(Icons.visibility);
  bool ishidden = true;
  void showpass() {
    if (ishidden) {
      iconhidden = const Icon(Icons.visibility_off);
      ishidden = !ishidden;
    } else {
      iconhidden = const Icon(Icons.visibility);
      ishidden = !ishidden;
    }
    emit(PasswordHiddenState());
  }

  UserModel? userModel;
  ErrorModel? errorModel;

  void registerUser({required Map<String, dynamic> data}) {
    emit(RegisterLodinState());

    Httplar.httpPost(path: REGISTERUSER, data: data).then((value) {
      if (value.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        userModel = UserModel.fromJson(jsonResponse);
        emit(RegisterStateGood(model: userModel!));
      } else if (value.statusCode == 400) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(errorModel: errorModel!));
      }
    }).catchError((e) {
      print(e.toString());
      emit(RegisterStateBad());
    });
  }

  void login({required Map<String, dynamic> data}) {
    emit(LoginLoadingState());
    print("Ggg");
    Httplar.httpPost(path: LoginUSER, data: data).then((value) {
      if (value.statusCode == 200) {
        print("kk");

        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        print(value.body);
        userModel = UserModel.fromJson(jsonResponse);
        print(userModel!.success);
        emit(LoginStateGood(model: userModel!));
      } else if (value.statusCode == 400 ||
          value.statusCode == 401 ||
          value.statusCode == 404) {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        errorModel = ErrorModel.fromJson(jsonResponse);
        emit(ErrorState(errorModel: errorModel!));
      }
    }).catchError((e) {
      print(e.toString());
      emit(LoginStateBad());
    });
  }
}
