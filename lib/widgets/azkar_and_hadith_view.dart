import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/model/surahmodel.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/settingsScreen.dart';
import 'package:muslim/widgets/utils/file_operation.dart';
import 'package:provider/provider.dart';

class AzkarandHadithView extends StatefulWidget {
  static const String routeName = "azkarAndHadithView";
  int ayahNum = 0;

  AzkarandHadithView({Key? key}) : super(key: key);

  @override
  State<AzkarandHadithView> createState() => _AzkarandHadithViewState();
}

class _AzkarandHadithViewState extends State<AzkarandHadithView> {
  late AppController provider;

  // ignore: prefer_typing_uninitialized_variables
  late var args;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppController>(context);
    var widthScreen = MediaQuery.of(context).size.width.w;
    args = ModalRoute.of(context)!.settings.arguments as SurahModel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: provider.isDarkTheme() ? ThemeDataProvider.backgroundDarkColor : ThemeDataProvider.backgroundLightColor,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(args.title,
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: ThemeDataProvider.mainAppColor,
                      )),
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
              Divider(
                indent: 40.sp,
                endIndent: 40.sp,
                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder(
                    future: getContent(args.fileNumber),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> lines) {
                      if (lines.data != null) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: EdgeInsets.all(5.0.sp),
                                child: Text(
                                  textAlign: TextAlign.justify,
                                  lines.data!.toString(),
                                  style: TextStyle(
                                    fontSize: Provider.of<AppController>(
                                        context,
                                        listen: true)
                                        .valueHolder
                                        .toDouble().sp,
                                    color:  provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<String> getContent(int NumOfSurah) async {
    FileOperations fileOperations = FileOperations();
    String data =
    await fileOperations.getDataFromFile('assets/txts/$NumOfSurah.txt');
    return formatContent(data);
  }

  String formatContent(String content) {
    if (args.isSurah) {
      // ignore: non_constant_identifier_names
      List<String> Surah = content.split('\n');
      String surahText = '';
      widget.ayahNum = 1;
      for (var line in Surah) {
        surahText += line;
        surahText += " (${widget.ayahNum}) ";
        widget.ayahNum++;
      }
      return surahText;
    } else {
      return content;
    }
  }
}