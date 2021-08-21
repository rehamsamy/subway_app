import 'package:flutter/material.dart';

import 'constraints.dart';

class CreateRequest extends StatefulWidget {


  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
        ],),
    );
  }




  // createRequestApi() async{
  //   Map<String,String> map={'USER_NAME':'5',
  //     'FROM_DESTINATION':'1',
  //     'TO_DESTINATION':'2' ,
  //     'DESCRIPTION':'ghhhhhhh',
  //     'SEND_DATE':_formattedDate};
  //   var res= await ServicesApi.createRequest(map);
  //   print('kkkk ${res}');
  //
  // }
}


