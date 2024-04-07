import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/model/error_model%20copy.dart';

import 'package:mosque/model/user_model.dart';

part 'terrain_state.dart';

class TerrainCubit extends Cubit<TerrainState> {
  TerrainCubit() : super(TerrainInitial());

  static TerrainCubit get(context) => BlocProvider.of<TerrainCubit>(context);
}
