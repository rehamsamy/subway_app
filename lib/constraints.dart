

import 'package:flutter/material.dart';

class Constraints extends StatelessWidget {
  static TextStyle styleGrayText=TextStyle(fontSize: 18,color: Colors.grey);

  static TextStyle blueStyle=TextStyle(color: Colors.blue.shade300,fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

 static Widget getAppbar(BuildContext context,Widget widget,String title){
    TextStyle _styleToolbar=TextStyle(fontSize: 18,color: Colors.grey);

 return  AppBar(
     backgroundColor: Colors.white,
     title: Text(title,style: _styleToolbar,),
     centerTitle: true,
     elevation: 20,
     leading:IconButton(icon:Icon(Icons.arrow_back,color: Colors.blue.shade300,size: 30,) ,onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
     },),

 );
  }


 static void getProgress(BuildContext context){
    var alert=AlertDialog(
      content: Container(
        height: 70,
        child: Column(
          children: [
            CircularProgressIndicator(color: Colors.blue.shade300,),
            SizedBox(height: 10,),
            Text('loading')
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_)=>alert);

    // return Visibility(child: CircularProgressIndicator(color: Colors.blue.shade300,),visible: true,);
  }

}
