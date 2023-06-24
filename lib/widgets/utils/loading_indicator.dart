import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muslim/provider/themeDataProvider.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const widget = CircularProgressIndicator(
      color: ThemeDataProvider.mainAppColor,
    );
    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}
