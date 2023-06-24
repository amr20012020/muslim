import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/provider/appcontroller.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muslim/widgets/location_error_widget.dart';
import 'package:muslim/widgets/utils/loading_indicator.dart';
import 'package:provider/provider.dart';



class QiblahCompass extends StatefulWidget {
  const QiblahCompass({Key? key}) : super(key: key);

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  var futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = Provider.of<AppController>(context,listen: false).checkLocationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0.sp),
      child: StreamBuilder(
        stream: Provider.of<AppController>(context,listen: false).stream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const LoadingIndicator();
          }
          if(snapshot.data!.enabled == true){
            switch(snapshot.data!.status){
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();
              case LocationPermission.denied:
                return LocationErrorWidget(
                  error: "Location Serveice Permission has denied",
                  callBack: futureAlbum,
                );
              case LocationPermission.deniedForever:
                return LocationErrorWidget(
                  error: "Location Service Denied Forever !",
                  callBack: futureAlbum,
                );
              default:
                return Container();
            }
          }else{
            return LocationErrorWidget(
              error: "Please enable Location serveice",
              callBack: futureAlbum,
            );
          }
        },

      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterQiblah().dispose();
  }

}




class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = SvgPicture.asset(
    'assets/images/compass.svg',
    color: ThemeDataProvider.mainAppColor,
  );

  final _needleSvg = SvgPicture.asset(
    'assets/images/needle.svg',
    fit: BoxFit.contain,
    height: 300.h,
    alignment: Alignment.center,
  );


  QiblahCompassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingIndicator();
        }
        final qiblahDirection = snapshot.data!;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>
            [
              Transform.rotate(
                  angle: (qiblahDirection.direction * (pi / 180) * -1),
                child: _compassSvg,
              ),

              Transform.rotate(
                angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                alignment: Alignment.center,
                child: _needleSvg,
              ),
              Positioned(
                  bottom: 8.sp,
                  child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°")),
            ],
          ),
        );
      },

    );
  }
}
