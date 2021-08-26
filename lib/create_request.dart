import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subway_app/sender_receiver.dart';
import 'package:toast/toast.dart';

import 'constraints.dart';
import 'models/dest_model.dart';
import 'models/request.dart';
import 'services_api/my_provider.dart';
import 'services_api/services_api.dart';


class CreateRequest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MyProvide>(
          create :(_)=>MyProvide(),
          child: CreateRequest1()),
    );
  }
}


class CreateRequest1 extends StatefulWidget {
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest1> {

  var _style = TextStyle(fontSize: 20);
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);
  DateTime _date;
  String _formattedDate;
  List<DestModel> _destList=[];
  var _descController=TextEditingController();
  var _priceController=TextEditingController();
  bool _isLoaded=true;
  int flag=0;

  GlobalKey<FormState> _priceKey=GlobalKey();
  GlobalKey<FormState> _descKey=GlobalKey();

  int fromToFlag=0;



  String dropdownValueFrom ;
  String dropdownValueTo ;
  int fromDestSerial;
  int toDestSerial;

  @override
  void initState() {
    Provider.of<MyProvide>(context,listen: false).getFromToDest();
  }
  @override
  Widget build(BuildContext context) {
    _destList=Provider.of<MyProvide>(context,listen: true).destList;
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue.shade300),
        // leading: Icon(Icons.home,color: Colors.blue.shade300,),
        actions: [
          Container(margin:EdgeInsets.symmetric(horizontal: 10),child: Icon(Icons.home,color: Colors.blue.shade300,)),
        ],
        title: Text('Create Request',style:TextStyle(fontSize: 18,color: Colors.grey)),
        centerTitle: true,
        elevation: 12,
      ),
      body: buildCreateRequestWidgt(),
      drawer: Drawer(

      ),
    );

  }


  Widget buildCreateRequestWidgt(){
    return  Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                  child: Text('FROM :'),
                ),
                SizedBox(width: 10,),
                buildDropDownListFrom(),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                  child: Text('TO :'),
                ),
                buildDropDownListTo(),
              ],
            ),

            SizedBox(height: 10,),
            getPriceWidget(),
            SizedBox(height: 20,),
            bulidDescriptionWidget(),
            SizedBox(height: 30,),

            buildDateRowWithText(),
            SizedBox(height: 10,),
            Divider(color: Colors.yellow.shade800,thickness: 1,indent: 60,endIndent: 60,),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(40, 60, 40, 0),
              height: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300
              ),
              child: FlatButton(child: Text('Create Request',style: _style1,),onPressed:()async{
                print('pressed');
                if(_formattedDate==null){
                  Toast.show('must enter date', context,duration: Toast.LENGTH_LONG);
                }else{
                  createRequestApi();
                }
              }

              ),
            ),
          ],
        ),
      ),
    );
  }

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
        child: FlatButton(child: Text('Date',style: _style1,),
          onPressed:()=> showDatePickerFn(context),
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
                showDatePickerFn(context)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: FlatButton.icon(onPressed: (){}, icon:Icon( Icons.timer), label: Text(_formattedDate,style: TextStyle(color: Colors.black,fontSize: 12))),

        )
      ],);

  }
  void showDatePickerFn(BuildContext  context) {
    print('v1');
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2015), lastDate: DateTime(2025)).
    then((value) =>setState(() {
      print('v2');
      _date=value;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      _formattedDate = formatter.format(_date);


      print('ggggggggg  ${_formattedDate}');
    }));
  }

  Widget getPriceWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(('PRICE :'), style: Constraints.blueStyle,),
        Form(
          key: _priceKey,
          child:
          Container(
            width: 200,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _priceController,
              textAlign: TextAlign.start,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter Valid Price';
                }
              },
              onSaved: (val) {},
              decoration: InputDecoration(
                suffixIcon:
                Image.asset('asset/images/pricec.png'),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                labelText: 'Enter Price',
              ),
            ),
          ),)
      ],);
  }

  void createRequestApi() async{
    double _price;
    try {
      _price = double.parse(_priceController.text);
    }catch(e){
      Toast.show('Please enter valid price', context,duration: Toast.LENGTH_LONG);
    }
    if(!_descKey.currentState.validate()&&!_priceKey.currentState.validate())
      return;
    if(fromDestSerial==toDestSerial){
      Toast.show('Please Choose another  To Dest ', context,duration: Toast.LENGTH_LONG);
    }else {
      Map<String, String> map = {'USER_NAME': '1',
        'FROM_DESTINATION': fromDestSerial.toString(),
        'TO_DESTINATION': toDestSerial.toString(),
        'DESCRIPTION': _descController.text,
        'PRICE': _priceController.text,
        'SEND_DATE': _formattedDate};
      // Constraints.getProgress(context);
      // Navigator.pop(context);
      print(map.toString());
      var res = await ServicesApi.createRequest(map);
      print(res);

      if (res == 'Request Created') {
        Toast.show(res, context, duration: Toast.LENGTH_LONG);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SenderReceiver()));
      } else {
        Toast.show(res, context, duration: Toast.LENGTH_LONG);
      }
    }

  }



  Widget bulidDescriptionWidget(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(('Description :'), style: Constraints.blueStyle,),
        Form(
          key: _descKey,
          child:
          Container(
            width: 300,
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: _descController,
              textAlign: TextAlign.start,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Enter Description';
                }
              },
              onSaved: (val) {},
              decoration: InputDecoration(
                suffixIcon:Icon(Icons.comment,color: Colors.yellow.shade800,),
                // Image.asset('asset/images/pricec.png'),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                labelText: 'Enter Description',
              ),
            ),
          ),)
      ],);
  }
}


