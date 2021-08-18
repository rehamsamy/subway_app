import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:subway_app/constraints.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHome> {
  TextStyle _styleToolbar=TextStyle(fontSize: 18,color: Colors.grey);
  int _current_index=1;
////
  List _images=['asset/images/main_slider_1.png',
    'asset/images/main_slider_3.jpeg',
    'asset/images/main_slider_4.jpg'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue.shade300),
          backgroundColor: Colors.white,
          title: Text('Main Page',style: _styleToolbar,),
          centerTitle: true,
          elevation: 20,
        ),

        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: CarouselSlider(items: _images.map((e) => Container(
                     margin: EdgeInsets.symmetric(horizontal: 8),
                       width:double.infinity,child: Image.asset(e,fit: BoxFit.fill,))).toList()
                       , options: CarouselOptions(autoPlay: true,enlargeCenterPage: true,
                       onPageChanged: (index,_){
                         setState(() {
                           _current_index=index;
                         });
                       })),

            ),
            SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircleIndcatorSlider(0),
                  buildCircleIndcatorSlider(1),
                  buildCircleIndcatorSlider(2),
                  buildCircleIndcatorSlider(3),

                ],

            ),
            Flexible(flex: 1,child: Stack(
                  children: [
                   Container(
                     margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                     child: Center(
                         child: Image.asset('asset/images/home_photo.png')),
                   ),
                    Column(
                      children: [
                        Card(
                          elevation: 20,
                          margin: EdgeInsets.fromLTRB(30, 40, 30, 5),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.blue.shade300,
                                ),
                                title: Text(
                                  'Sender',
                                  style: Constraints.styleGrayText,
                                  textAlign: TextAlign.start,
                                ),
                            onTap: (){},),
                          ),
                        ),
                        Card(
                          elevation: 20,
                          margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.blue.shade300,
                                ),
                                title: Text(
                                  'Receiver',
                                  style: Constraints.styleGrayText,
                                  textAlign: TextAlign.start,
                                ),
                            onTap: (){},),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  padding: EdgeInsets.all(5),



                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: FlatButton(child: Text('Create new request',style: TextStyle(color: Colors.white,fontSize: 18),),
                  onPressed: (){},),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


 Widget buildCircleIndcatorSlider(int index){
    return Container(
     width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
            color: _current_index==index?Colors.blue.shade300:Colors.yellow.shade700
      ),
    );
  }
}
