import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class ServicesApi{

 static Future loginApi(Map<String,String> map)async{
    var url='http://sub-way.herokuapp.com/LOGIN_API';
   print(map.toString());
    final responce=await http.get(Uri.parse(url),headers: map);
    if(responce.statusCode==200){
      var obj=json.decode(responce.body);
      print('sucess');
      return obj;
    }else{
      print(responce.body);
    }
  }


 static Future registerUser(Map<String,String> map)async{
   var url='http://sub-way.herokuapp.com/REGISTER_API';
   print(map.toString());
   final responce=await http.get(Uri.parse(url),headers: map);
   if(responce.statusCode==200){
     var obj=json.decode(responce.body);
     print('sucess');
     return obj;
   }else{
     print(responce.body);
   }
 }

}