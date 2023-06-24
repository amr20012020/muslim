import 'package:flutter/cupertino.dart';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:muslim/model/surahmodel.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/widgets/content_view.dart';

class SurahItem extends StatelessWidget {
  final String name, verse;
  final int fileNumber;
  final Color color;
  bool isRTL;
  SurahItem({
    Key? key,
    required this.name,
    required this.fileNumber,
    required this.color,
    required this.verse,
    required this.isRTL,
  }) : super(key: key);

  double sizeNumbering = 40;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    ArabicNumbers arabicNumber = ArabicNumbers();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ContentView.routeName,
            arguments: SurahModel(name, fileNumber, true));
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width.w - 10.w,
        height: 70.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Center(
                            child: Text(
                              arabicNumber.convert(fileNumber.toString()),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          width: sizeNumbering.w,
                          height: sizeNumbering.h,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 40.h,
                          child: Image.asset(
                            "assets/sName/sname_$fileNumber.png",
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${arabicNumber.convert(verse)} ${verse}",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: color),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            color: provider.isDarkTheme()
                                ? ThemeDataProvider.textDarkThemeColor
                                : ThemeDataProvider.textLightThemeColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color:  provider.isDarkTheme()
                    ? Colors.white70
                    : Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
