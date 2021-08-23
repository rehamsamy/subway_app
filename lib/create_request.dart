import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'constraints.dart';
import 'models/dest_model.dart';
import 'models/request.dart';
import 'services_api/services_api.dart';


class CreateRequest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateRequest1(),
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
  List<RequestModel> _requestsList=[];
  var _descController=TextEditingController();
  var _priceController=TextEditingController();
  bool _isLoaded=true;
  int flag=0;


  String dropdownValueFrom ;
  String dropdownValueTo ;
  int fromDestSerial;
  int toDestSerial;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildCreateRequestWidgt(),


    );
  }


 Widget buildCreateRequestWidgt(){
  return  Container(
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

        SizedBox(height: 10,),
        getPriceWidget(),
        SizedBox(height: 20,),
        bulidDescriptionWidget(),
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
        ),
      ],
    ),
  );
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
    Map<String,String> map={'USER_NAME':'1',
      'FROM_DESTINATION':'1',
      'TO_DESTINATION':'2' ,
      'DESCRIPTION':'bbbbbbb',
      'SEND_DATE':_formattedDate};
Constraints.getProgress(context);
    var res=await ServicesApi.createRequest(map);
    print(res);

    if(res=='Request Created'){
      Toast.show(res, context,duration: Toast.LENGTH_LONG);
    }else{
      Toast.show(res, context,duration: Toast.LENGTH_LONG);
    }

    Navigator.pop(context);
  }



  Widget bulidDescriptionWidget(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(('Description :'), style: Constraints.blueStyle,),
        Form(
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
                suffixIcon:
                Image.asset('asset/images/pricec.png'),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                labelText: 'Enter Description',
              ),
            ),
          ),)
      ],);
  }
}


