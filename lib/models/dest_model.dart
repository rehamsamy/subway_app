import 'package:flutter/material.dart';

class DestModel{
  final String name;
  final int dest_serial;


  DestModel({@required this.name,@required this.dest_serial});


  factory DestModel.fromJson(Map<String, dynamic> json) {
    return DestModel(
      name: json['NAME'],
      dest_serial: json['ds_serial'],
    );
  }
}


class DestList{
   List<dynamic> destList;

  DestList({@required this.destList});

  factory DestList.fromJson(List<dynamic> list){
    return DestList(
        destList:list );
  }
}