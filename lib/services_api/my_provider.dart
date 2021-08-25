import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:subway_app/models/dest_model.dart';
import 'package:subway_app/models/request.dart';

class MyProvide with ChangeNotifier{
  int flag=0;
  List<RequestModel> requests=[];
  List<DestModel> destList = [];
  String dropValueFrom;
  String dropValueTo;


  void getFlag(int f){
    if(f==1){
      flag=1;
      //dropValue=destList[0].name;
    }
    notifyListeners();

    print('flag ${flag}');
  }

  void setValueDestFrom(String x){
    if(x==null){
      dropValueFrom=destList[0].name;
    }
    dropValueFrom=x;
    notifyListeners();
  }

  void setValueDestTo(String x){
    if(x==null){
      dropValueTo=destList[0].name;
    }
    dropValueTo=x;
    notifyListeners();
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




  Future<List<DestModel>> getFromToDest() async {
    Map<String,String> map={
      'FROM':'',
      'LANG':'EN'
    };
    final response =
    await http.get(
        Uri.parse('https://sub-way.herokuapp.com/GETDESTINATION_API'),headers: map);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> values = new List<dynamic>();
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            destList.add(DestModel.fromJson(map));
            notifyListeners();
            print('Id-------${destList.length}');
          }
        }
      }

      return destList;
    } else {
      print('ccccccccccccc');
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}