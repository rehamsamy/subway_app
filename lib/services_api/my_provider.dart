import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subway_app/models/request.dart';

class MyProvide with ChangeNotifier{
  int flag=0;
  List<RequestModel> requests=[];


 void getFlag(int f){
   if(f==1){
     flag=1;
   }
    notifyListeners();

   print('flag ${flag}');
  }




   Future<List<RequestModel>> getAllRequests(Map<String,String> map)async{
    //List<RequestModel> requests = new List<RequestModel>();

    final response =
    await http.get(
        Uri.parse('https://sub-way.herokuapp.com/GETALLREQUESTES_API'),
        headers: map);
    print('ffffffffffff 1');
    if (response.statusCode == 200) {
      print('ffffffffffff 2');
      List<dynamic> values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          print('Id-------${values[i]}');
          Map<String, dynamic> map = values[i];
          requests.add(RequestModel.fromJson(map));
          notifyListeners();
          print('Id-------${map['description']}');
        }
      }
      return requests;
    } else {
      print('ffffffffffff 3');
      throw Exception('Failed to load post');
    }


  }

}