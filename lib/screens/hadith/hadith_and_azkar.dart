import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/azkar/azkarScreen.dart';
import 'package:muslim/screens/hadith/HadithScreen.dart';
import 'package:provider/provider.dart';

class HadithAndAzkar extends StatefulWidget {
  const HadithAndAzkar({Key? key}) : super(key: key);

  @override
  State<HadithAndAzkar> createState() => _HadithAndAzkarState();
}

class _HadithAndAzkarState extends State<HadithAndAzkar> with SingleTickerProviderStateMixin{
   late TabController tabController;

   List<Tab> tabs_en = <Tab>[
     const Tab(text: "Hadith",),
     const Tab(text: "Azkar",),
   ];


   List<Tab> tabs_ar = <Tab>[
     const Tab(text: "الاحاديث",),
     const Tab(text: "الاذكار",),
   ];


   List<Widget> widgets = <Widget>[
     const HadithScreen(),
     const AzkarScreen(),
   ];

   @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: widgets.length,);
  }

  late bool isRTL;



  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;

    final TextDirection currentDirection = Directionality.of(context);
    isRTL = currentDirection == TextDirection.rtl;

    late AppController provider = Provider.of<AppController>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: widthScreen > 1000.sp
                  ? provider.isDarkTheme()
                  ? const AssetImage(
                  ThemeDataProvider.imageBackgroundDarkWeb)
                  : const AssetImage(
                  ThemeDataProvider.imageBackgroundLightWeb)
                  : provider.isDarkTheme()
                  ? const AssetImage(ThemeDataProvider.imageBackgroundDark)
                  : const AssetImage(
                  ThemeDataProvider.imageBackgroundLight),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              height: heightScreen * 0.15.h,
              decoration: BoxDecoration(
                color: ThemeDataProvider.mainAppColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.sp),
                  bottomRight: Radius.circular(25.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      provider.isEnglish() ? "Al-Quran" : "القرآن الكريم",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: provider.isDarkTheme() ? ThemeDataProvider.textLightThemeColor :ThemeDataProvider.textDarkThemeColor,
                      ),
                    ),
                    TabBar(
                       indicatorColor: ThemeDataProvider.textDarkThemeColor,
                        labelColor: ThemeDataProvider.textDarkThemeColor,
                        labelStyle: TextStyle(fontSize: 20.sp),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: tabController,
                        tabs: provider.isEnglish() ? tabs_en : tabs_ar,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(controller: tabController, children: widgets,),
            ),
          ],
        ),
      ),
    );
  }
}
