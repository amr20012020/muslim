import 'dart:convert';

import 'package:muslim/model/radio_model.dart';
import 'package:http/http.dart' as http;
import 'package:muslim/widgets/utils/radio_controller.dart';

class RadioResponse{
  List<Radio> radios;

  RadioResponse.fromJsonMap(Map<String,dynamic> map)
    : radios = List<Radio>.from(
       map["radios"].map(
           (it) => Radio.fromJson(it),
       ),
  );
}



Future<RadioResponse> getRadioStations(String api)async{
  final url = Uri.parse(api);
  final response = await http.get(url);
  if(response.statusCode == 200){
    return RadioResponse.fromJsonMap(jsonDecode(response.body));
  }else{
    throw Exception("Failed to load data");
  }
}