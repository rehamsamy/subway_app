import 'package:flutter/material.dart';

class RequestModel {

  final int from_dest;
  final int rq_serial;
  final int to_dest;
  final String request_flag;
  final String request_status;
  final int requsted_by;
  final String description;
  final double price;


  RequestModel(
      {@required this.from_dest, @required this.rq_serial, @required this.to_dest, @required this.request_flag,
        @required this.request_status, @required this.requsted_by, @required this.description,
      @required this.price});


  factory RequestModel.fromJson(Map<String, dynamic> map){
    return RequestModel(from_dest: map['from_destination'],
        rq_serial: map['rq_serial'],
        to_dest: map['to_destination'],
        request_flag: map['request_flag'],
        request_status: map['request_status'],
        requsted_by: map['requsted_by'],
        description: map['description'],
        price:map['price']);
  }
}
class Requests{
  final List<RequestModel> requests;

  Requests({@required this.requests});
}


