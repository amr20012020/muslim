import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/widgets/utils/loading_indicator.dart';
import 'package:muslim/widgets/utils/radio_controller.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RadioScreen extends StatefulWidget {
  static const String routeName = "radio-screen";
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  bool isPlaying = false;
  final RadioPlayer _radioPlayer = RadioPlayer();
  late AppController provider = Provider.of<AppController>(context);

  late String radioUrl;
  late Future<RadioResponse> radioStations;

  //List<String>? metadata;


  static int index = 0;
  String arabicRadio = "https://api.mp3quran.net/radios/radio_arabic.json";
  String englishRadio = "https://api.mp3quran.net/radios/radio_english.json";


  @override
  void initState() {
    super.initState();
    play();
  }




  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;

    final TextDirection currentDirection = Directionality.of(context);
    final bool isLTR = currentDirection == TextDirection.ltr;

    radioStations = isLTR ? getRadioStations(englishRadio) : getRadioStations(arabicRadio);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.isEnglish() ? "Radio" : "الراديو",
          style: TextStyle(
            color: ThemeDataProvider.textDarkThemeColor,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: ThemeDataProvider.mainAppColor,
      ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
            child: Column(
              children:
              [
                Center(
                  child: FutureBuilder<RadioResponse>(
                    future: radioStations,
                    builder: (context, stations) {
                      if(stations.hasData){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h,),
                            SizedBox(
                              child: Lottie.asset('assets/images/radio.json'),
                            ),
                            SizedBox(
                              height: heightScreen * 0.05.h,
                            ),
                            SizedBox(
                              height: heightScreen * 0.05.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    child: IconButton(
                                      onPressed: () {
                                        isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                                      },
                                      icon: Icon(
                                        isPlaying ? Icons.pause : Icons.play_arrow,
                                        size: 30.sp,
                                        color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              provider.isEnglish() ? "Public broadcasting" : "الاذاعه العامه",
                              style: TextStyle(
                                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                             provider.isEnglish() ? "to read the Holy Quran" : "لقراءه القران الكريم ",
                              style: TextStyle(
                                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              provider.isEnglish() ? "for different readers" : "لمختلف القراء ",
                              style: TextStyle(
                                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * 0.05.h,
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        );
                      } else if(stations.hasError){
                        return  Text(provider.isEnglish() ? "Error Loading" : "خطا غير مقصود");
                      }
                      return const LoadingIndicator();
                    },

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


  void play(){
    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.setChannel(
        title: "Radio Quran",
        url: "https://Qurango.net/radio/mix",
        imagePath: "assets/images/time.jpg",
    );
  }


  void next(String radioStation, int length){
    index == length ? index : index++;
    _radioPlayer.setChannel(
        title: "RadioQuran",
        url: radioStation,
        imagePath: "assets/images/time.jpg",
    );
    setState(() {

    });
  }
}
