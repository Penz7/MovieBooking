import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_booking/firebase_options.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/network/controller/auth_controller.dart';
import 'package:movie_booking/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  const fallbackLocale = Locale('vi', 'VN');
  // if (language == "vi") {
  //   fallbackLocale = const Locale("vi", "VN");
  // }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: UIColors.white,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi', 'VN'),
      startLocale: const Locale('vi', 'VN'),
      child: const MyApp(
        initLanguage: fallbackLocale,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,   
    required this.initLanguage,
  });
  final Locale initLanguage;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.noScaling,
                    ),
                    child: child!,
                  );
                },
                theme: ThemeData(
                  scaffoldBackgroundColor: UIColors.white,
                  useMaterial3: true,
                  appBarTheme: const AppBarTheme(
                    surfaceTintColor: Colors.white,
                  ),
                  textTheme: GoogleFonts.quicksandTextTheme(),
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: UIColors.text,
                  ),
                  primaryColor: UIColors.splash,
                ),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                home: const SplashScreen(),
              );
  }
}
