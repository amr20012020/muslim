
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/azkar/azkar_item.dart';
import 'package:muslim/widgets/utils/file_operation.dart';
import 'package:provider/provider.dart';


class AzkarScreen extends StatefulWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  var azkarName = [];

  late AppController provider = Provider.of<AppController>(context);


  @override
  void initState() {
    getAzkarContent();
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
              image: widthScreen > 1000.w
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
          children:
          [
            Expanded(
                child: ListView.builder(
                   padding: EdgeInsets.only(top: 10.0.sp),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context,index) => AzkarItem(azkarName.elementAt(index),index +1),
                    itemCount: azkarName.length,
                )),

          ],
        ),
      ),
    );
  }

  getAzkarContent()async{
    FileOperations fileOperations = FileOperations();
    String data = await fileOperations.getDataFromFile('assets/content/azkar_names.txt');
    azkarName = data.split("\n");
    setState(() {});
  }
}
