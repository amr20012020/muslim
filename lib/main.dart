
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/LoadingScreen.dart';
import 'package:muslim/screens/azkar/azkarScreen.dart';
import 'package:muslim/screens/hadith/hadith_and_azkar.dart';
import 'package:muslim/screens/onBoardingScreen.dart';
import 'package:muslim/screens/quran/QuranScreen.dart';
import 'package:muslim/screens/settingsScreen.dart';
import 'package:muslim/screens/splachScreen.dart';
import 'package:muslim/widgets/azkar_and_hadith_view.dart';
import 'package:muslim/widgets/content_view.dart';
import 'package:muslim/widgets/utils/preferences.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

int? initScreen;
Future<void> main() async {
 WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
 FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Preferences.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(/*DevicePreview(
    builder: (context) =>*/
  ChangeNotifierProvider(
      create: (BuildContext context) => AppController(), child: MyApp()),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppController(),
      builder: (buildContext, widget) {
        final provider = Provider.of<AppController>(context);
        provider.themeMode = Preferences.getThemePreference();
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context,child){
            return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              //locale:Locale.fromSubtags(languageCode: Preferences.getLanguage())/* Locale(provider.currentLanguage)*/,
              /*builder: (context, child) => ResponsiveBreakpoints(
                  child: LandingScreen(),
                  breakpoints: [
                    const Breakpoint(start: 0, end: 450, name: MOBILE),
                    const Breakpoint(start: 451, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                    const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                  ])
              /*DevicePreview.appBuilder*/,*/
              themeMode: provider.themeMode,
              darkTheme: ThemeDataProvider.darkTheme,
              theme: ThemeDataProvider.lightTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: initScreen == 0 || initScreen == null
                  ? SplachScreen.routeName
                  : LandingScreen.routeName,
              routes: {
                SplachScreen.routeName: (context) => const SplachScreen(),
                onBoardingPage.routeName: (context) => onBoardingPage(),
                LandingScreen.routeName: (context) => const LandingScreen(),
                QuranScreen.routeName: (context) => const QuranScreen(),
                ContentView.routeName: (context) => ContentView(),
                AzkarandHadithView.routeName: (context) => AzkarandHadithView(),
                SettingsScreen.routeName: (context) => const SettingsScreen(),
              },
            );
          }
        );
      },
    );
  }
}
