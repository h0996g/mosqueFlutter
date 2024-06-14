import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/firebase_options.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/helper/observer.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/home/home.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/Auth/onboarding.dart';
import 'package:mosque/screen/userScreens/home/home.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget = Login();
  // CachHelper.removdata(key: "onbording");
  bool onbordingmain = await CachHelper.getData(key: 'onbording') ?? false;
  TOKEN = await CachHelper.getData(key: 'TOKEN') ?? '';

  if (TOKEN != '') {
    DECODEDTOKEN = JwtDecoder.decode(TOKEN);
    if (DECODEDTOKEN['role'] == 'user') {
      startWidget = const HomeUser();
    } else if (DECODEDTOKEN['role'] == 'admin') {
      startWidget = const HomeAdmin();
    }
  }
  runApp(MyApp(
    startwidget: startWidget,
    onbordingmain: onbordingmain,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  final bool onbordingmain;

  const MyApp(
      {super.key, required this.startwidget, required this.onbordingmain});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
        BlocProvider(
          create: ((context) => HomeAdminCubit()..getMyInfo()),
        ),
        BlocProvider(
          create: ((context) => ProfileAdminCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()..getMyInfo()),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // supportedLocales: const [
        //   Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        // ],
        locale: const Locale(
          "fr",
          "FR",
        ),
        debugShowCheckedModeBanner: false,
        home:

            // Onbording(),

            onbordingmain ? startwidget : const Onbording(),
      ),
    );
  }
}
