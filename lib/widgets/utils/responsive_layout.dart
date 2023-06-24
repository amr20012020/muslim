import 'package:flutter/cupertino.dart';
import 'package:muslim/widgets/utils/constant.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  ResponsiveLayout({required this.desktopBody,required this.mobileBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < AppConstant.mobiledevice){
            return mobileBody;
          }else{
            return desktopBody;
          }
        });
  }
}
