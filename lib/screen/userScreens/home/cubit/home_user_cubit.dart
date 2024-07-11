import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/Api/constApi.dart';
import 'dart:convert' as convert;

import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/section_model.dart';
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
        print(userDataModel!.sectionProgress!
            .map((e) => e.completedLessons?.map((e) => e.score)));
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

  Future<void> updateLessonCompletionStatus(
      {required String idlesson,
      required String idSection,
      required int score}) async {
    emit(UpdateLessonCompletionStatusLoading());
    await Httplar.httpPost(path: COMPLETLESSONPROGRESS, data: {
      "lessonId": idlesson,
      "score": score,
      "sectionId": idSection
    }).then((value) {
      if (value.statusCode == 200) {
        dynamic jsonResponse = convert.jsonDecode(value.body);

        if (jsonResponse is List) {
          List<SectionProgress> sectionProgress =
              jsonResponse.map((e) => SectionProgress.fromJson(e)).toList();
          userDataModel!.sectionProgress = sectionProgress;
        } else if (jsonResponse is Map<String, dynamic>) {
          Map<String, dynamic> responseMap = jsonResponse;
          if (responseMap.containsKey('sectionProgress')) {
            userDataModel!.sectionProgress =
                (responseMap['sectionProgress'] as List)
                    .map((e) => SectionProgress.fromJson(e))
                    .toList();
          }
        }

        print(userDataModel!.sectionProgress!.first);
        emit(UpdateLessonCompletionStateGood());
      } else {
        var jsonResponse =
            convert.jsonDecode(value.body) as Map<String, dynamic>;
        ErrorModel error_model = ErrorModel.fromJson(jsonResponse);
        print(error_model.message);
        emit(ErrorState(model: error_model));
      }
    }).catchError((e) {
      print(e.toString());
      emit(UpdateLessonCompletionStateBad());
    });
  }
}
