import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subway_app/constraints.dart';

class SenderReceiver extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SenderReceiver1(),
    );
  }
}


class SenderReceiver1 extends StatefulWidget {
  @override
  _SenderReceiverState createState() => _SenderReceiverState();
}

class _SenderReceiverState extends State<SenderReceiver1> {
  var _style = TextStyle(fontSize: 20);
  DateTime _date;

  var x = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.blue.shade300,
            labelColor: Colors.blue.shade300,
            unselectedLabelColor: Colors.grey,
            labelStyle: _style,
            tabs: [
              Tab(text: 'sender',),
              Tab(text: 'receiver',)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildSenderTab(),
            Center(child: Text('data')),
          ],
        ),
      ),

    );
  }

  Widget buildSenderTab() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 120,
              child: ExpansionTile(
                  title: Text('FROM'),
                  children: [
                  ]
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            Container(
              width: 120,
              child: ExpansionTile(
                  title: Text('TO'),
                  children: [
                  ]
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(('PRICE :'), style: Constraints.blueStyle,),
            Form(
              child:
              Container(
                width: 200,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  //controller: _emailController,
                  textAlign: TextAlign.start,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter Valid Price';
                    }
                  },
                  onSaved: (val) {},
                  decoration: InputDecoration(
                    prefixIcon:
                    Image.asset('asset/images/pricec.png'),
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    labelText: 'Enter Price',
                  ),
                ),
              ),)
          ],),
        SizedBox(height: 20,),
        RaisedButton(onPressed: () {
          showDatePicker(context: context, initialDate: DateTime.now(),
              firstDate: DateTime(2018), lastDate: DateTime.now());
        },
        child: _date==null?Text(''):Text('${_date}'),)
        ,
      ],
    );
  }

  void showDatePickerFn() {
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2018), lastDate: DateTime.now()).
   then((value) =>setState(() {
      _date=value;
      print(value.day);
    }));
  }
}
