
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muslim/screens/LoadingScreen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = "setting-screen";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppController provider = Provider.of<AppController>(context);



  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: heightScreen,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: widthScreen > 1000.sp
                  ? provider.isDarkTheme()
                  ? const AssetImage(
                ThemeDataProvider.imageBackgroundDarkWeb,
              )
                  : const AssetImage(
                ThemeDataProvider.imageBackgroundLightWeb,
              )
                  : provider.isDarkTheme()
                  ? const AssetImage(
                ThemeDataProvider.imageBackgroundDark,
              )
                  : const AssetImage(
                  ThemeDataProvider.imageBackgroundLight),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: widthScreen.w,
                height: heightScreen * 0.25.h,
                decoration: BoxDecoration(
                  color: ThemeDataProvider.mainAppColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.sp),
                    bottomRight: Radius.circular(25.sp),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: ThemeDataProvider.mainAppColor,
                        radius: widthScreen * 0.12.w,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: heightScreen * 0.1.h,
                          width: widthScreen * 0.5.w,
                          child: Center(
                            child: Image.asset(
                              "assets/images/quran.png",
                              fit: BoxFit.cover,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "`وَأَنَّ سَعْيَهُۥ سَوْفَ يُرَىٰ`",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: "quranFont",
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              settings(context),
              SizedBox(
                height: 10.h,
              ),
              fromApp(context),
              SizedBox(
                height: 10.h,
              ),
              developers(context),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LandingScreen()));
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.backward,
                        color: Color(0xff097209),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Amr 2023 © All Copy Rights Reserved",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settings(BuildContext context) {
    late AppController provider = Provider.of<AppController>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: ThemeDataProvider.mainAppColor,
          ),
          child: Center(
            child: Icon(
              Icons.settings,
              color: const Color.fromARGB(255, 245, 241, 241),
              size: 24.sp,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "Settings" : "الاعدادات",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                child: Text(
                  "كَلا إِنَّ مَعِيَ رَبِّي سَيَهْدِينِ",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "quranFont",
                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
              Slider(
                activeColor: ThemeDataProvider.mainAppColor,
                value: Provider.of<AppController>(context , listen: true).valueHolder.toDouble(),
                min: 14.sp,
                max: 44.sp,
                label: '${Provider.of<AppController>(context, listen: true).valueHolder.round()}',
                onChanged: (double newValue) {
                  setState(() {
                    Provider.of<AppController>(context, listen: false).saveFontSize(newValue.round());
                  });
                },
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()}';
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width.w,
                height: 50.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isEnglish() ? "Language" : "اللغه",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                        ),
                      ),
                      CupertinoSwitch(
                        value: provider.isEnglish() ? true : false,
                        onChanged: (value) {
                          setState(() {
                            provider.isEnglish()
                                ? provider.changeLanguage('ar')
                                : provider.changeLanguage('en');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width.w,
                height: 50.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        provider.isEnglish() ? "Night Mode" : "الوضع الليلي",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                        ),
                      ),
                      CupertinoSwitch(
                        value: provider.isDarkTheme() ? true : false,
                        onChanged: (value) {
                          setState(() {
                            provider.isDarkTheme() ? provider.changeToLightTheme() : provider.changeToDarkTheme();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget fromApp(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: ThemeDataProvider.mainAppColor,
          ),
          child: Center(
            child: Icon(
              Icons.info_outline,
              color: const Color.fromARGB(255, 245, 241, 241),
              size: 24.sp,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "About" : "عن التطبيق",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10.sp,right: 10.sp),
            child: Text(
              provider.isEnglish() ? "Al-Quran" : "القرآن الكريم",
              style:TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "quranFont",
                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
              ),
            ),
          ),
          ListTile(
            title: Text(
             provider.isEnglish()
                 ? "The application of the Holy Qur’an helps you to read the surahs and verses wherever you go and remember the times of prayer with determining the direction of the qiblah. There is also our Holy Qur’an radio station. We also give you the possibility to glorify God and display hadiths and remembrances."
               : "تطبيق القرآن الكريم يساعدك على قرآه السور والايات أينما ذهبت وتذكر مواعيد الصلاه مع تحديد اتجاه القبله كما أنه يوجد اذاعه القرآن الكريم الخاصه بنا كما نتيح لكم امكانيه تسبيح الله وعرض الاحاديث والاذكار",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget developers(BuildContext context){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
      child: ExpansionTile(
        iconColor: ThemeDataProvider.mainAppColor,
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: ThemeDataProvider.mainAppColor,
          ),
          child: Center(
            child: Icon(
              Icons.person,
              color: const Color.fromARGB(255, 245, 241, 241),
              size: 24.sp,
            ),
          ),
        ),
        title: Text(
          provider.isEnglish() ? "Developers" : "المطورين",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
          ),
        ),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                child: Text(
                  provider.isEnglish() ? "Amr Ahmed" : "عمرو احمد",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "quranFont",
                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                child: Text(
                  provider.isEnglish() ? "Flutter developer" : "مطور تطبيقات",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "quranFont",
                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              provider.isEnglish() ?
              "Experienced Information Technology Specialist with a demonstrated history of working in the computer software industry. Skilled in Mobile Application Development, IT Service Management, and Volunteering"
              : "متخصص في تكنولوجيا المعلومات من ذوي الخبرة ولدي تاريخ مثبت في العمل في صناعة برامج الكمبيوتر. ماهر في تطوير تطبيقات الهاتف المحمول، وإدارة خدمات تكنولوجيا المعلومات ، والعمل التطوعي",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
