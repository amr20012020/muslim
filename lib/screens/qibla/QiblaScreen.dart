import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/qibla/QiblaScreen.dart';
import 'package:muslim/screens/qibla/qibla_Compass.dart';
import 'package:muslim/widgets/utils/loading_indicator.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:provider/provider.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final deviceSupprot = FlutterQiblah.androidDeviceSensorSupport();
  late AppController provider = Provider.of<AppController>(context);



  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height.h;
    var widthScreen = MediaQuery.of(context).size.width.w;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.isEnglish() ? "Qibla" : "القبله",
          style: TextStyle(
            color: ThemeDataProvider.textDarkThemeColor,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
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
        child: FutureBuilder(
          future: deviceSupprot,
          builder: (_, AsyncSnapshot<bool?> snapshot) { 
            if(snapshot.connectionState == ConnectionState.waiting){
              return const LoadingIndicator();
            }
            if(snapshot.hasError){
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            }
            if(snapshot.data!){
              return QiblahCompass();
            }else{
              return const Center(child: Text("UnExpected Error!"),);
            }
          },
        ),
      ),

    );
  }
}
