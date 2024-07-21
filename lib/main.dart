import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/firebase_options.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/helper/observer.dart';
import 'package:mosque/helper/socket.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/home/home.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/component/category/cubit/category_cubit.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mosque/screen/welcome_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget = Login();
  // CachHelper.removdata(key: "TOKEN");
  // bool onbordingmain = await CachHelper.getData(key: 'onbording') ?? false;
  TOKEN = await CachHelper.getData(key: 'TOKEN') ?? '';

  if (TOKEN != '') {
    DECODEDTOKEN = JwtDecoder.decode(TOKEN);
    if (DECODEDTOKEN['role'] == 'user') {
      startWidget = const WelcomeScreen();
    } else if (DECODEDTOKEN['role'] == 'admin') {
      startWidget = const HomeAdmin();
    }
  }
  final SocketService _socketService = SocketService();
  _socketService.connect();
  runApp(MyApp(
    startwidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  const MyApp({super.key, required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
        BlocProvider(
          create: ((context) => HomeAdminCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileAdminCubit()),
        ),
        BlocProvider(
          create: ((context) => ProfileCubit()),
        ),
        BlocProvider(
          create: ((context) => HomeUserCubit()),
        ),
        BlocProvider(
          create: ((context) => CategoryCubit()),
        ),
        BlocProvider(
          create: ((context) => LessonCubit()),
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

            startwidget,
      ),
    );
  }
}
