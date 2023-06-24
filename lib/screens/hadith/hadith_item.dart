import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/model/surahmodel.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/widgets/azkar_and_hadith_view.dart';
import 'package:provider/provider.dart';

class HadithItem extends StatelessWidget {
  String name;
  int fileNumber;

  HadithItem(this.name, this.fileNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    ArabicNumbers arabicNumbers = ArabicNumbers();
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,
            AzkarandHadithView.routeName,
          arguments: SurahModel(name, (fileNumber + 1000), false),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width.w - 10.w,
        height: 70.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
          child: Column(
            children:
            [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeDataProvider.mainAppColor,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      height: 40.h,
                      width: 40.w,
                      child: Center(
                        child: Text(
                          arabicNumbers.convert(fileNumber.toString()),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: ThemeDataProvider.textDarkThemeColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: provider.isDarkTheme() ? ThemeDataProvider.textDarkThemeColor :ThemeDataProvider.textLightThemeColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: provider.isDarkTheme()
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
