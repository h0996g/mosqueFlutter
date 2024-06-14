import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/model/error_model.dart';

part 'annonce_state.dart';

class AnnonceCubit extends Cubit<AnnonceState> {
  AnnonceCubit() : super(AnnonceInitial());

  static AnnonceCubit get(context) => BlocProvider.of<AnnonceCubit>(context);
}
