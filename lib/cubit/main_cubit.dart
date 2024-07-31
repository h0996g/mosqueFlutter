import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mosque/helper/cachhelper.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  Locale locale = CachHelper.getData(key: 'lang') == null
      ? const Locale('en')
      : Locale(CachHelper.getData(key: 'lang'));
  void changeLanguage(Locale locale) {
    this.locale = locale;
    CachHelper.putcache(key: 'lang', value: locale.languageCode);

    emit(MainChangeLanguage());
  }
}
