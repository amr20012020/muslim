import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/model/adhan_model.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/quran/surah_item.dart';
import 'package:muslim/screens/settingsScreen.dart';
import 'package:muslim/widgets/utils/file_operation.dart';
import 'package:muslim/widgets/utils/loading_indicator.dart';
import 'package:provider/provider.dart';

class QuranScreen extends StatefulWidget {
  static const String routeName = "quran-screen";

  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late bool isRTL;
  var surahsNames = [];
  var surahsVerses = [];
  ArabicNumbers arabicNumbers = ArabicNumbers();
  Future<AdhanModel>? futureAdahan;

  @override
  void initState() {
    super.initState();
    getSurahContent();
    futureAdahan =
        Provider.of<AppController>(context, listen: false).futureAdahan();
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;
    final TextDirection currentDirection = Directionality.of(context);
    isRTL = currentDirection == TextDirection.rtl;
    var provider = Provider.of<AppController>(context);

    return Scaffold(
      body: Container(
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
        child: Column(
          children: [
            /*SizedBox(
              height: 20.h,
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SettingsScreen()));
                    },
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: ThemeDataProvider.mainAppColor,
                      size: 32.sp,
                    ),
                  ),
                ),
                Align(
                  alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Text(
                      provider.isEnglish() ? "Hello Brother" : "السلام عليكم",
                      style: TextStyle(
                        color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                        fontSize: 24.sp,
                        fontFamily: "quranFont",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Stack(
              children: [
                FutureBuilder<AdhanModel>(
                  future: futureAdahan,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.only(left: 20.0.sp, right: 20.sp),
                        child: Container(
                          width: widthScreen * 0.95.w,
                          height: 250.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    const AssetImage("assets/images/time.jpg"),
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.withOpacity(0.9),
                                    BlendMode.darken),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(25.sp),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.isEnglish()
                                          ? isRTL
                                              ? snapshot.data!.data!.date!
                                                  .hijri!.month!.en!
                                              : snapshot.data!.data!.date!
                                                  .hijri!.month!.en!
                                          : isRTL
                                              ? snapshot.data!.data!.date!
                                                  .hijri!.month!.ar!
                                              : snapshot.data!.data!.date!
                                                  .hijri!.month!.ar!,
                                      style: TextStyle(
                                          color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                          fontSize: 16.sp,
                                          fontFamily: "quranFont"),
                                    ),
                                    Text(
                                      provider.isEnglish()
                                          ? isRTL
                                              ? snapshot.data!.data!.date!
                                                  .hijri!.month!.ar!
                                              : snapshot.data!.data!.date!
                                                  .hijri!.weekday!.en!
                                          : isRTL
                                              ? snapshot.data!.data!.date!
                                                  .hijri!.month!.ar!
                                              : snapshot.data!.data!.date!
                                                  .hijri!.weekday!.ar!,
                                      style: TextStyle(
                                          color: ThemeDataProvider.mainAppColor,
                                          fontSize: 16.sp,
                                          fontFamily: "quranFont"),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  isRTL
                                      ? arabicNumbers.convert(
                                          snapshot.data!.data!.date!.readable!
                                              .toString()!,
                                        )
                                      : snapshot.data!.data!.date!.readable!
                                          .toString()!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26.sp),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  isRTL
                                      ? arabicNumbers.convert(
                                          snapshot
                                              .data!.data!.date!.hijri!.date!,
                                        )
                                      : snapshot.data!.data!.date!.hijri!.date!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 26.sp),
                                ),
                              ),
                              const Spacer(),
                              const Spacer(),
                              Positioned(
                                top: heightScreen * 0.21.h,
                                child: FutureBuilder<AdhanModel>(
                                  future: futureAdahan,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<String> SalahNames = [
                                        "الفجر",
                                        "الشروق",
                                        "الظهر",
                                        "العصر",
                                        "المغرب",
                                        "العشاء",
                                        "الامساك",
                                      ];

                                      List<String> SalahNamesEn = [
                                        "Fajer",
                                        "Shoruk",
                                        "Dohr",
                                        "Asr",
                                        "Majreb",
                                        "Asha",
                                        "Imsak",
                                      ];

                                      List<String> times = [
                                        snapshot.data!.data!.timings!.fajr!,
                                        snapshot.data!.data!.timings!.sunrise!,
                                        snapshot.data!.data!.timings!.dhuhr!,
                                        snapshot.data!.data!.timings!.asr!,
                                        snapshot.data!.data!.timings!.maghrib!,
                                        snapshot.data!.data!.timings!.isha!,
                                        snapshot.data!.data!.timings!.imsak!,
                                      ];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 5.sp, left: 5.sp),
                                            height: 80.h,
                                            width: widthScreen * 0.95.w,
                                            child: ListView.builder(
                                                itemCount: SalahNames.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, i) {
                                                  return Padding(
                                                    padding: EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.sp),
                                                    child: Container(
                                                      width: 80.0.w,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .transparent
                                                            .withOpacity(0.5.sp),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25.sp),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            provider.isEnglish()
                                                                ? SalahNamesEn[
                                                                    i]
                                                                : SalahNames[i],
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            isRTL
                                                                ? arabicNumbers
                                                                    .convert(
                                                                    times[i],
                                                                  )
                                                                : times[i],
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: ThemeDataProvider
                                                                  .mainAppColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return const LoadingIndicator();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const LoadingIndicator();
                  },
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.only(top: 15.sp),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => SurahItem(
                name: surahsNames.elementAt(index),
                fileNumber: index + 1,
                color: ThemeDataProvider.mainAppColor,
                isRTL: isRTL,
                verse: surahsVerses.elementAt(index),
              ),
              itemCount: surahsNames.length,
            )),
          ],
        ),
      ),
    );
  }

  getSurahContent() async {
    FileOperations fo = FileOperations();
    String data = await fo.getDataFromFile('assets/content/sura_names.txt');
    surahsNames = data.split("\n");
    data = await fo.getDataFromFile('assets/content/suras_nums.txt');
    surahsVerses = data.split("\n");
    setState(() {});
  }
}
