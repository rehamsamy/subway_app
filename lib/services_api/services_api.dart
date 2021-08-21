import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:subway_app/models/dest_model.dart';
import 'package:subway_app/models/request.dart';


class ServicesApi {


  static Future loginApi(Map<String, String> map) async {
    var url = 'http://sub-way.herokuapp.com/LOGIN_API';
    print(map.toString());
    final responce = await http.get(Uri.parse(url), headers: map);
    if (responce.statusCode == 200) {
      var obj = json.decode(responce.body);
      print('sucess');
      return obj;
    } else {
      print(responce.body);
    }
  }


  static Future registerUser(Map<String, String> map) async {
    var url = 'http://sub-way.herokuapp.com/REGISTER_API';
    print(map.toString());
    final responce = await http.post(Uri.parse(url), headers: map,);
    if (responce.statusCode == 200) {
      print('sucess  ${jsonDecode(responce.body)}');
      //var obj=json.decode(responce.body);
      return responce.body;
    } else {
      print(responce.body);
      print('fail');
    }
  }

  static Future createRequest(Map<String, String> map) async {
    var url = 'http://sub-way.herokuapp.com/CREATEREQUEST_API';

    final http.Response response = await http.post(
      Uri.parse(url),headers: map,
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
    );


    if (response.statusCode == 200) {
      print('sucess ${response.body}');
      return jsonEncode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }


 static Future<List<DestModel>> fetchDest() async {
    List<DestModel> _postList = new List<DestModel>();

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
            _postList.add(DestModel.fromJson(map));
            print('Id-------${map['NAME']}');
          }
        }
      }
      return _postList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  static Future getAllRequests(Map<String,String> map)async{
    List<RequestModel> requests = new List<RequestModel>();

    final response =
        await http.get(
        Uri.parse('https://sub-way.herokuapp.com/GETALLREQUESTES_API'),headers: map);
print('ffffffffffff 1');
    if(response.statusCode==200){
      print('ffffffffffff 2');
      List<dynamic> values=json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          print('Id-------${values[i]}');
          Map<String, dynamic> map = values[i];
          requests.add(RequestModel.fromJson(map));
          print('Id-------${map['description']}');
        }
      }
          return requests;
    }else{
      print('ffffffffffff 3');
      throw Exception('Failed to load post');
    }
  }

}

