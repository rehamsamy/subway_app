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
  Widget build(BuildContext context) {

    //fetchDest();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          elevation: 20,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.home,color: Colors.blue.shade300,))
          ],
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
        drawer: Drawer(),
      ),

    );
  }

  Widget buildSenderTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: Text('FROM :'),
                  ),
                  SizedBox(width: 10,),
                  buildDropDownListFromTo(dropdownValueFrom),
                  SizedBox(width: 10,),
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

   Expanded(flex:2,child: flag==0?Center(child:Text('choose from , to dest and date to get all requests!!')):
    getAllRequestsList(context)
    // GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: 100,
    //     childAspectRatio: 1.5,
    //     crossAxisSpacing: 20,
    //     mainAxisSpacing: 20
    // ),
    //   children: _requestsList.map((e) => RequestItemCard(RequestModel('hhh','hh','hh','l'))).toList(),),
    //
   )
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


  Widget buildDropDownListFromTo(String dropValue){
    return FutureBuilder(
        future: ServicesApi.fetchDest(),
        builder: (ctx, snapshot){
          print('x1');
         // _destList=ServicesApi.fetchDest();
          if (snapshot.connectionState == ConnectionState.done) {
            print('x2');
            _destList=snapshot.data;
            return
                  DropdownButton(
                    value: snapshot.hasData?_destList[0]:null,
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
                        //print(val);
                        DestModel model=_destList.firstWhere((element) => val.name==element.name);
                        fromDestSerial=model.dest_serial;
                        toDestSerial=model.dest_serial;
                       // print('drop 1 : ${model}');
                     });
                    },
                    items: snapshot.data.map<DropdownMenuItem<DestModel>>((DestModel value) {
                      return DropdownMenuItem<DestModel>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  );
          }
          else {
            print('x3');
            //Toast.show('error', context,duration: Toast.LENGTH_LONG);
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }


  Widget getAllRequestsList(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, String> map = {
      'USER_NAME': '1',
      'FROM_DESTINATION': '1',
      'TO_DESTINATION': '2',
      'SEND_DATE': _formattedDate
    };
    return FutureBuilder(
      future:ServicesApi.getAllRequests(map) ,
      builder: (ctx,snapshot){
       // Future.delayed(Duration(seconds: 1));
      if( snapshot.connectionState==ConnectionState.done&& snapshot.hasData){
        _requestsList=snapshot.data;
        print('jjjjj ${fromDestSerial}');
        return Container(
           height:100 ,
              child: GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
              ),
              children: _requestsList.map((e) => RequestItemCard(e)).toList(),),
            );
        }else if(snapshot.connectionState==ConnectionState.waiting){
        Constraints.getProgress(ctx);
       Navigator.pop(context);
      }else if(_requestsList.isEmpty){
        return Center(child: Text('no data'),);
      }

      },
    );


  }


//   int fetchFromToDestPlaceSerial(){
//    DestModel model= _destList.firstWhere((element) => element.name==dropdownValueTo);
//    print(model.dest_serial);
//    return model.dest_serial;
//
// }
}