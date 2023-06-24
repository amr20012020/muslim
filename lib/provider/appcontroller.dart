import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muslim/model/adhan_model.dart';
import 'package:http/http.dart' as http;
import 'package:muslim/widgets/utils/constant.dart';
import 'package:muslim/widgets/utils/preferences.dart';

class AppController extends ChangeNotifier{
  late ThemeMode themeMode = ThemeMode.light;

  String currentLanguage = 'en';

  int valueHolder = 20;

  final LocationStreamController = StreamController<LocationStatus>.broadcast();
  get stream => LocationStreamController.stream;

  checkLocationStatus()async{
    final locationStauts = await FlutterQiblah.checkLocationStatus();
    if(locationStauts.enabled && locationStauts.status == LocationPermission.denied){
      await FlutterQiblah.requestPermissions();
      final qibla = await FlutterQiblah.checkLocationStatus();
      LocationStreamController.sink.add(qibla);
    }else{
      LocationStreamController.sink.add(locationStauts);
    }
    notifyListeners();
  }


  Future<AdhanModel> futureAdahan()async{
    final response = await http.get(
      Uri.parse(AppConstant.Base_Url + AppConstant.Location_Url),
      headers: {
        "Accept" : "application/json",
        "Access-Control-Allow-Origin" : "*"
      },
    );
    if(response.statusCode == 200){
      return AdhanModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load adhan');
    }

  }


  void saveFontSize(int newValue){
    valueHolder = newValue;
    notifyListeners();
  }


  void changeToLightTheme(){
    themeMode = ThemeMode.light;
    Preferences.saveThemePreference(themeMode);
    notifyListeners();
  }

  void changeToDarkTheme(){
    themeMode = ThemeMode.dark;
    Preferences.saveThemePreference(themeMode);
    notifyListeners();
  }

  bool isDarkTheme(){
    return themeMode == ThemeMode.dark;
  }


  bool isEnglish(){
    return currentLanguage == 'en';
  }



void changeLanguage(String lang){
    currentLanguage = lang;
    Preferences.setLanguage(currentLanguage);
    notifyListeners();
}

  
}