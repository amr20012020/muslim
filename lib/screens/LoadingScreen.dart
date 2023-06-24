import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/hadith/HadithScreen.dart';
import 'package:muslim/screens/hadith/hadith_and_azkar.dart';
import 'package:muslim/screens/qibla/QiblaScreen.dart';
import 'package:muslim/screens/quran/QuranScreen.dart';
import 'package:muslim/screens/radio/RadioScreen.dart';
import 'package:muslim/screens/settingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = 'landing-Screen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  List screens = [
    const QuranScreen(),
    const HadithAndAzkar(),
    const QiblaScreen(),
    const RadioScreen(),
    const SettingsScreen(),
  ];

  void onTapNavigator(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: provider.isDarkTheme()
            ? ThemeDataProvider.primaryDarkThemeColor
            : ThemeDataProvider.primaryLightThemeColor,
        selectedItemColor: ThemeDataProvider.mainAppColor,
        unselectedItemColor: provider.isDarkTheme()
            ? ThemeDataProvider.textDarkThemeColor
            : ThemeDataProvider.textLightThemeColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNavigator,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: provider.isEnglish()
                  ? "Quran"
                  : "القران" /*AppLocalizations.of(context)!.quran*/),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined),
              label: provider.isEnglish()
                  ? "Hadith"
                  : "الاحاديث" /*AppLocalizations.of(context)!.hadith*/),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration_sharp),
              label: provider.isEnglish()
                  ? "Qibla"
                  : "القبله" /*AppLocalizations.of(context)!.qibla*/),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio),
              label: provider.isEnglish()
                  ? "Radio"
                  : "الراديو" /*AppLocalizations.of(context)!.radio*/),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: provider.isEnglish()
                  ? "Setting"
                  : "الاعدادات" /*AppLocalizations.of(context)!.setting*/),
        ],
      ),
    );
  }
}
