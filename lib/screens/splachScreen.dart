import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim/screens/onBoardingScreen.dart';


class SplachScreen extends StatefulWidget {
  static const String routeName = "splach-screen";

  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    super.initState();
    navigateHome();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          child: Lottie.asset(
              "assets/images/allah.json",
            animate: true,
          ),
        ),
      ),
    );
  }
  void navigateHome()async{
    await Future.delayed(Duration(seconds: 7), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => onBoardingPage()));
  }
}