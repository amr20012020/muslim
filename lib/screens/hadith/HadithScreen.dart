import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/hadith/hadith_item.dart';
import 'package:muslim/widgets/utils/file_operation.dart';
import 'package:provider/provider.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  late AppController provider = Provider.of<AppController>(context);
  var hadethName = [];


  @override
  void initState() {
    getHadethContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;
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
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0.sp),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: hadethName.length,
                    itemBuilder: (context,index) => HadithItem(hadethName.elementAt(index), index +1),
                ),
            ),
          ],
        ),
      ),
    );
  }


  getHadethContent()async{
    FileOperations fileOperations = FileOperations();
    String data = await fileOperations.getDataFromFile('assets/content/hades_names.txt');
    hadethName = data.split("\n");
    setState(() {

    });
  }
}
