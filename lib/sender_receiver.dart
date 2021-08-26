import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_app/constraints.dart';
import 'package:intl/intl.dart';
import 'package:subway_app/create_request.dart';
import 'package:subway_app/models/dest_model.dart';
import 'package:subway_app/request_item_card.dart';
import 'package:subway_app/services_api/my_provider.dart';
import 'package:subway_app/services_api/services_api.dart';
import 'package:toast/toast.dart';
import 'models/request.dart';

class SenderReceiver extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
   debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light,accentColor: Colors.blue.shade300,
          primaryColor: Colors.white,
      canvasColor: Colors.white),

      home: ChangeNotifierProvider<MyProvide>(
          create :(_)=>MyProvide(),
          child: SenderReceiver1()),
    );
  }
}




class SenderReceiver1 extends StatefulWidget {
  @override
  _SenderReceiverState createState() => _SenderReceiverState();
}

class _SenderReceiverState extends State<SenderReceiver1> {

  var _style = TextStyle(fontSize: 20);
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white,);
  DateTime _date;
  String _formattedDate;
  List<DestModel> _destList=[];
  List<RequestModel> _requestsList=[];

  bool _isLoaded=true;
  int flag=0;
  int fromToFlag=0;


  String dropdownValueFrom ;
  String dropdownValueTo ;
  int fromDestSerial;
  int toDestSerial;


  var x = ['1', '2', '3', '4'];


  @override
  void initState() {
    super.initState();
    Provider.of<MyProvide>(context,listen: false).getFromToDest();

  }

  @override
  Widget build(BuildContext context) {
    _destList=Provider.of<MyProvide>(context,listen: true).destList;
    _requestsList=Provider.of<MyProvide>(context,listen: true).requests;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue.shade300),
          actions: [
            Container(
                margin:EdgeInsets.all(5),child: IconButton(icon:Icon(Icons.home,color: Colors.blue.shade300,),onPressed: (){},)),
          ],
          //leading: Icon(Icons.home,color: Colors.blue.shade300,),
          title: Text('All Requests',style: TextStyle(fontSize: 18,color: Colors.grey),),
          centerTitle: true,
          elevation: 10,
        ),
        body:
        Column(
          children: [
            Card(
              elevation: 5,
              child:TabBar(
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

            Flexible(
              flex: 1,
              child: TabBarView(
                children: [
                  buildSenderTab(),
                  Center(child: Text('data')),
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          elevation: 20,
          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateRequest())),
        ),
      ),

    );
  }

  Widget buildSenderTab() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    padding: const EdgeInsets.fromLTRB(0,0,5,0),
                    child: Text('FROM :',style: TextStyle(color: Colors.blue.shade300,fontSize: 15),),
                  ),
                  SizedBox(width: 5,),
                  buildDropDownListFrom(),
                  SizedBox(width: 5,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,5,0),
                    child: Text('TO :',style: TextStyle(color: Colors.blue.shade300,fontSize: 15),),
                  ),
                  buildDropDownListTo(),
                ],
              ),

              SizedBox(height: 20,),
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
                  child: FlatButton(child: Text('Get Requests',style: _style1,),onPressed:(){
                    //print(Provider.of<MyProvide>(context,listen: true).flag);
                    if(_formattedDate==null){
                      Toast.show('must enter date', context,duration: Toast.LENGTH_LONG);
                    }else{
                      Map<String, String> map = {
                        'USER_NAME': '1',
                        'FROM_DESTINATION': fromDestSerial.toString(),
                        'TO_DESTINATION':toDestSerial.toString(),
                        'SEND_DATE': _formattedDate
                      };
                      Provider.of<MyProvide>(context, listen: false)
                          .getAllRequests(map);
                      Provider.of<MyProvide>(context,listen: false).getFlag(1);

                      print('flag ${flag}');
                    }

                    print('fffffff   >>>> ${fromDestSerial}    ..... ${_requestsList.length}');

                  }



                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 2,child:
        buildExpandedRequestsList()),

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

//............................. build drop down from to dest  ...............................
  Widget buildDropDownListFrom() {
    TextStyle _style=TextStyle(fontSize: 16,color: Colors.deepOrange);
    return _destList.length==0? CircularProgressIndicator():
    DropdownButton(
      hint: Container(
        width: 90,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Card(elevation:8,child: Center(child:
        Provider.of<MyProvide>(context,listen: true).dropValueFrom==null?Text('Dest',style: _style,):
        Text(Provider.of<MyProvide>(context,listen: true).dropValueFrom,style: _style,),
        ))
        ,),

      icon: Icon(Icons.arrow_drop_down,color: Colors.blue.shade300,),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.red, fontSize: 18),
      underline: Container(
        height: 2,
      ),
      onChanged: (val){
        print(val.name);
        setState(() {
          fromToFlag=1;
          fromDestSerial=val.dest_serial;
        });


        print('zzzzzzzzz ${fromDestSerial}  mjhh  ${toDestSerial}');
        Provider.of<MyProvide>(context,listen: false).setValueDestFrom(val.name);
      },
      items: _destList.map<DropdownMenuItem<DestModel>>((DestModel value) {
        return DropdownMenuItem<DestModel>(
          value: value,
          child: Text(value.name,style: TextStyle(),),
        );
      }).toList(),
    );

  }


  Widget buildDropDownListTo() {
    TextStyle _style=TextStyle(fontSize: 16,color: Colors.deepOrange);
    return _destList.length==0? CircularProgressIndicator():
    DropdownButton(
      hint: Container(
        width: 90,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Card(elevation:8,child: Center(child:
        Provider.of<MyProvide>(context,listen: true).dropValueTo==null?Text('Dest',style: _style,):
        Text(Provider.of<MyProvide>(context,listen: true).dropValueTo,style: _style,),
        ))
        ,),
      icon: Icon(Icons.arrow_drop_down,color: Colors.blue.shade300,),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.red, fontSize: 18),
      underline: Container(
        height: 2,
      ),
      onChanged: (val){
        print(val.name);
        setState(() {
          toDestSerial=val.dest_serial;
          fromToFlag=1;
        });

        Provider.of<MyProvide>(context,listen: false).setValueDestTo(val.name);
      },
      items: _destList.map<DropdownMenuItem<DestModel>>((DestModel value) {
        return DropdownMenuItem<DestModel>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );

  }

  //..........   get all Request lis ........................................//
  Widget getAllRequestsList(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, String> map = {
      'USER_NAME': '1',
      'FROM_DESTINATION': '1',
      'TO_DESTINATION': '2',
      'SEND_DATE': '2021-08-09'
    };
    //Constraints.getProgress(context);
    Future.delayed(Duration(seconds :10));
    return FutureBuilder (
      future:ServicesApi.getAllRequests(map) ,
      builder: (ctx,snapshot){
        Future.delayed(Duration(seconds: 1));
        if( snapshot.connectionState==ConnectionState.done&& snapshot.hasData){
          _requestsList=snapshot.data;
          print('jjjjj ${fromDestSerial}');
          return  Container(
            child: GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width/2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20
            ),
              children: _requestsList.map((e) => buildRequestItemCard(e,context)).toList(),
            ),
          );
        }else if(snapshot.connectionState==ConnectionState.waiting){
          // Constraints.getProgress(ctx);
          Navigator.pop(context);
        }else if(_requestsList.isEmpty){
          return Center(child: Text('no data'),);
        }

      },
    );
  }


  ///////////// build request item card///////////////////////////////
  Widget buildRequestItemCard( RequestModel requestModel,BuildContext context){
    String  image='asset/images/wishlist_not_select.png';
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        child:Stack(
          children: [
            Image.asset('asset/images/home_photo.png',fit: BoxFit.cover),
            Positioned(
                right: 5,
                bottom: 10,
                child: Text(requestModel.price.toString(),style: TextStyle(color: Colors.green),)),
            Positioned(left: 0,
                top: 0,
                child: IconButton(icon:Image.asset(
                    Provider.of<MyProvide>(context,listen: true).image==null?image:
                    Provider.of<MyProvide>(context,listen: true).image
                ),onPressed:()=>
                    Provider.of<MyProvide>(context,listen: false).setWishListImage(image, context)
                  ,)
            ),
            Positioned(
                left: 5,
                bottom: 10,child: Text(requestModel.description,style: TextStyle(color: Colors.black),))
          ],
        ) ,
      ),
    );
  }

  buildExpandedRequestsList() {
    if( Provider.of<MyProvide>(context,listen: true).flag==0){
      return Center(child:Text('choose from , to dest and date to get all requests!!'));
    }else if(Provider.of<MyProvide>(context,listen: true).requests.isEmpty){
      return Center(child:Text('Empty Requests'));
    }else{
      return  GridView(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width/2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
      ),
        children: _requestsList.map((e) => buildRequestItemCard(e,context)).toList(),
      );
    }


  }


}