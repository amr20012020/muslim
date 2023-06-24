
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/model/surahmodel.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/widgets/colors.dart';
import 'package:muslim/widgets/utils/file_operation.dart';
import 'package:quran/quran.dart' as quran;


import 'package:provider/provider.dart';

class ContentView extends StatefulWidget {
  static const String routeName = "ContentView";
  int ayaNum = 0;

  ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late AppController provider;
  late var args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SurahModel;
    provider = Provider.of<AppController>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: screenWidth > 1000.sp
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: Image.asset(
                      "assets/sName/sname_${args.fileNumber}.png",
                      color: ThemeDataProvider.mainAppColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: ThemeDataProvider.mainAppColor,
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
             /* IconButton(
                onPressed: (){},
                icon: Icon(
                  CupertinoIcons.play_arrow_solid,
                  size: 17.w,
                ),
              ),*/
              Divider(
                indent: 40.sp,
                endIndent: 40.sp,
                color: provider.isDarkTheme() ? Colors.white70 : Colors.grey.shade700,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.all(5.0.sp),
                      child: FutureBuilder(
                        future: getContent(args.fileNumber),
                        builder: (BuildContext context, AsyncSnapshot<String> lines) {
                          if(lines.data != null){
                            return Column(
                              children: [
                                SizedBox(
                                  height: 35.h,
                                  child: Image.asset(
                                      "assets/images/img_bismillah.png",
                                    color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor : ThemeDataProvider.textLightThemeColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0.sp),
                                      child: Text(
                                        textScaleFactor: 1.3.sp,
                                        textAlign: TextAlign.justify,
                                        lines.data!.toString(),
                                        style: TextStyle(
                                          fontFamily: "quranFont",
                                          fontSize: Provider.of<AppController>(context, listen: true).valueHolder.toDouble(),
                                          color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor : ThemeDataProvider.textLightThemeColor,
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          }else{
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },

                      ),
                    ),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<String> getContent(int NumOfSurah) async {
    FileOperations fileOperations = FileOperations();
    String data =
    await fileOperations.getDataFromFile('assets/txts/$NumOfSurah.txt');
    return formatContent(data);
  }

  String formatContent(String content) {
    ArabicNumbers arabicNumber = ArabicNumbers();

    if (args.isSurah) {
      // ignore: non_constant_identifier_names
      List<String> Surah = content.split('\n');
      String surahText = '';
      widget.ayaNum = 1;
      for (var line in Surah) {
        surahText += line;
        surahText += " (${arabicNumber.convert(widget.ayaNum.toString())}) ";
        widget.ayaNum++;
      }
      return surahText;
    } else {
      return content;
    }
  }

  int index = -1;
  int pressCount = 0;

  Widget getAudioIcon({required int ayahNumber, required int idx}) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      CircleAvatar(
        radius: 15.w,
        backgroundColor: AppColors.secondaryColor,
        child: IconButton(
          onPressed: (){
            setState(() {
              pressCount++;
              if(pressCount % 2 != 0){
                index = idx;
              }else{
                index = -1;

              }
            });
          },
          icon: index == idx ? Icon(
            CupertinoIcons.pause,
            color: Colors.black,
            size: 17.w,
          ) : Icon(
            CupertinoIcons.play_arrow_solid,
            color: Colors.white,
            size: 15.w,
          ),
        ),
      ),
    ],
  );



  /*void playAudio({required int ayahNumber}){
    String url = quran.getAudioURLByVerse(widget., ayahNumber);
}*/
}



