import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subway_app/constraints.dart';
import 'package:intl/intl.dart';
import 'package:subway_app/models/dest_model.dart';
import 'package:subway_app/request_item_card.dart';
import 'package:subway_app/services_api/services_api.dart';
import 'package:toast/toast.dart';

import 'models/request.dart';

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
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);
  DateTime _date;
   String _formattedDate;
   List<DestModel> _destList=[];
   List<RequestModel> _requestsList=[];

   bool _isLoaded=true;
   int flag=0;


  String dropdownValueFrom ;
  String dropdownValueTo ;
  int fromDestSerial;
  int toDestSerial;


  var x = ['1', '2', '3', '4'];
  @override
  void initState() {
    super.initState();
    if(_isLoaded==true){
      fetchDest();

    }else{

    }

   print(_destList.length);
  }

  @override
  Widget build(BuildContext context) {

    fetchDest();
    print('nnnnn  ${_destList.length}');
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
        SizedBox(height: 20,),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: Text('FROM :'),
                  ),
                  buildDropDownListFromTo(dropdownValueFrom),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: Text('TO :'),
                  ),
                  buildDropDownListFromTo(dropdownValueTo),
                ],
              ),

              SizedBox(height: 20,),
              // Divider(color: Colors.yellow.shade700,thickness: 1,indent: 60,endIndent: 60,),
              // SizedBox(height: 10,),
              buildDateRowWithText(),
              SizedBox(height: 10,),
              Divider(color: Colors.yellow.shade700,thickness: 1,indent: 60,endIndent: 60,),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 40),
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade300
                ),
                child: Center(
                  child: FlatButton(child: Text('Get Requests',style: _style1,),onPressed:()async{
                        print('pressed');
                       if(_formattedDate==null){
                         Toast.show('must enter date', context,duration: Toast.LENGTH_LONG);
                       }else{
                         //fetchFromToDestPlaceSerial();
                         Constraints.getProgress(context);
                         await  fetchRequests(_formattedDate,fromDestSerial,toDestSerial);
                         Navigator.pop(context);
                         setState(() {
                           flag=1;
                         });
                       }
                  }

                  ),
                ),
              ),
            ],
          ),
        ),
      
   Expanded(flex:2,child: flag==0?Center(child:Text('Empty')):
   getAllRequestsList(context))
      ],
    );
  }


  Widget buildDateRowWithText(){
   return _date==null?
    Container(
      width: 100,
      height: 42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade300
      ),
      child: Center(
        child: FlatButton(child: Text('Date',style: _style1,),onPressed: ()=>
            showDatePickerFn()
        ),
      ),
    )
        :
       Row(
         mainAxisAlignment:MainAxisAlignment.center,
         children: [
         Container(
           width: 100,
           height: 42,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.blue.shade300
           ),
           child: Center(
             child: FlatButton(child: Text('Date',style: _style1,),onPressed: ()=>
                 showDatePickerFn()
             ),
           ),
         ),
         Padding(
           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: FlatButton.icon(onPressed: (){}, icon:Icon( Icons.timer), label: Text(_formattedDate,style: TextStyle(color: Colors.black,fontSize: 12))),

         )
       ],);

  }
  void showDatePickerFn() {


    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2015), lastDate: DateTime(2025)).
   then((value) =>setState(() {
      _date=value;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      _formattedDate = formatter.format(_date);


      print('ggggggggg  ${_formattedDate}');
    }));
  }



  void fetchDest() async{
  _destList=  await ServicesApi.fetchDest();
  print(_destList.length);
  }

  Widget buildDropDownListFromTo(String dropValue){

   return Container(
        width: 100,
        child: _destList.length==0?
        SizedBox(height:20,width: 20,child: CircularProgressIndicator(color: Colors.blue.shade300)):
        DropdownButton(
          value: _destList[0],
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.red, fontSize: 18),
          underline: Container(
            height: 2,
           // color: Colors.deepPurpleAccent,
          ),
          onChanged: (val){
            setState(() {
              dropValue=val.name;
              print(val);
              DestModel model=_destList.firstWhere((element) => val.name==element.name);
              fromDestSerial=model.dest_serial;
              toDestSerial=model.dest_serial;
              print('drop 1 : ${model}');
            });
          },
          items: _destList.map<DropdownMenuItem<DestModel>>((DestModel value) {
            return DropdownMenuItem<DestModel>(
              value: value,
              child: Text(value.name),
            );
          }).toList(),
        )
    );
  }


  Widget getAllRequestsList(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
 //Constraints.getProgress(context);
    if (_requestsList.length == 0) {
     // return  CircularProgressIndicator(color: Colors.blue.shade300,);
      print('p');
    } else {
      print('g');
    }
    return _requestsList.isEmpty ?
    Center(child: Text('empty requests')) :
    Container(
      height: 300,
      child: GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: width/2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
      children: _requestsList.map((e) => RequestItemCard(e)).toList(),),
    );
    Center(
      child: Container(
        height: 100,
        child: ListView(
          children: _requestsList.map((e) => Text(e.description)).toList(),
        ),
      ),
    );


  }

  void fetchRequests(String date,from,to) async {
    Map<String, String> map = {
      'USER_NAME': '1',
      'FROM_DESTINATION': from.toString(),
      'TO_DESTINATION': '2',
      'SEND_DATE': date
    };
    print('fffff ${ from.toString() }');
    _requestsList = await ServicesApi.getAllRequests(map);
    print(_requestsList.length);
  }


int fetchFromToDestPlaceSerial(){
   DestModel model= _destList.firstWhere((element) => element.name==dropdownValueTo);
   print(model.dest_serial);
   return model.dest_serial;

}


}
