import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim/provider/themeDataProvider.dart';
import 'package:muslim/screens/LoadingScreen.dart';


class onBoardingPage extends StatelessWidget {
  static const String routeName = "onBoardingScreen";

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "'قَالَ  أَسْلَمْتُ  لِرَبِّ  الْعَالَمِينَ'",
          body:
              'تطبيق القرآن يساعدك على قراءه القرآن وتدبر معانيه ومعرفه مواقيت الصلاه وتسبيح الله وقرآه الاذكار والادعيه أينما ذهبت',
          image: Lottie.asset('assets/images/muslim.json'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: "'وَحَيْثُ مَا كُنتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ'",
          body: 'مواقيت الصلاه تساعدك على تذكر اوقات الصلاه بسهوله تامه',
          image: Lottie.asset('assets/images/kaba.json'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title:
              "'فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚإِنَّهُ كَانَ تَوَّابً'",
          body:
              'هنالك الكثير من الاحاديث والادعيه والاذكار والتسبيح وتحديد اتجاه القبله ',
          image: Lottie.asset('assets/images/muslim2.json'),
          decoration: buildDecoration(),
        ),
      ],
      next: Icon(
        Icons.navigate_before,
        size: 40.sp,
        color: ThemeDataProvider.mainAppColor,
      ),
      done: Text(
        "Done",
        style: TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20.sp),
      ),
      onDone: () => goToHome(context),
      dotsDecorator: getDotDecorator(),
      showSkipButton: true,
      skip: Text(
        'Skip',
        style: TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20.sp),
      ),
      onSkip: () => goToHome(context),
      animationDuration: 1000,
      globalBackgroundColor: Colors.white,
      rtl: true,
    );
  }

  DotsDecorator getDotDecorator() => DotsDecorator(
        color: Colors.grey,
        size:  Size(10.sp, 10.sp),
        activeColor: ThemeDataProvider.mainAppColor,
        activeSize: Size(22.sp, 10.sp),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.sp),
        ),
      );

  void goToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LandingScreen()));
}

Widget buildImage(String path) => Center(
      child: Image.asset(path),
    );

PageDecoration buildDecoration() => PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 26.0.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "quranFont",
        color: ThemeDataProvider.mainAppColor,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 20.sp,
        fontFamily: "quranFont",
      ),
      bodyAlignment: Alignment.bottomCenter,
      imageAlignment: Alignment.bottomCenter,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(
        top: 50.sp,
        left: 10.sp,
        right: 10.sp,
      ),
    );
