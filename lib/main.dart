import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/helper/observer.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/home/home.dart';
import 'package:mosque/theme/theam.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  Widget startWidget = Login();
  // CachHelper.removdata(key: "TOKEN");
  // TOKEN = await CachHelper.getData(key: 'TOKEN') ?? '';

  if (TOKEN != '') {
    DECODEDTOKEN = JwtDecoder.decode(TOKEN);
    startWidget = const Home();
  }

  runApp(MyApp(
    startwidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  const MyApp({super.key, required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("fa", "IR"),
      debugShowCheckedModeBanner: false,
      theme: light_theme(),
      home: startwidget,
    );
  }
}
