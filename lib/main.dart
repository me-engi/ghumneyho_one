import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/const_colors.dart';
import 'firebase_options.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, //Firebase initialization
  );
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        // for web app
        useInheritedMediaQuery: true, //for keyboard not overlapp
        // //designSize: const Size(1080, 1920), //for android application
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            initialRoute:'/',
            title: 'Ghumneyho',
            defaultTransition: Transition.rightToLeft,
            debugShowCheckedModeBanner: false,
            getPages: Routes.pages,
            theme: ThemeData(
                primaryColor: ConstColors.primaryColor,
                cardColor: ConstColors.backgroundColor,
                fontFamily: GoogleFonts.inter().fontFamily,
                textTheme: GoogleFonts.interTextTheme(
                  Theme.of(context).textTheme,
                ),
                colorScheme:
                    ColorScheme.fromSeed(seedColor: ConstColors.primaryColor),
                useMaterial3: true,
                appBarTheme: const AppBarTheme(
                    color: ConstColors.backgroundColor,
                    surfaceTintColor: ConstColors.backgroundColor),
                scaffoldBackgroundColor: ConstColors.backgroundColor),
          );
        });
  }
}
