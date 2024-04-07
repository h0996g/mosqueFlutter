import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;

import 'package:mosque/Api/constApi.dart';
import 'package:mosque/Api/httplaravel.dart';
import 'package:mosque/model/error_model%20copy.dart';

part 'annonce_state.dart';

class AnnonceCubit extends Cubit<AnnonceState> {
  AnnonceCubit() : super(AnnonceInitial());

  static AnnonceCubit get(context) => BlocProvider.of<AnnonceCubit>(context);
}
