import 'package:flutter/material.dart';
import 'package:subway_app/recovery_passord_2.dart';

import 'constraints.dart';
import 'login.dart';

class RecoveryPassword1 extends StatefulWidget {

  @override
  _RecoveryPassword1State createState() => _RecoveryPassword1State();
}

class _RecoveryPassword1State extends State<RecoveryPassword1> {
  GlobalKey<FormState> _formKey=GlobalKey();
  var _emailController=TextEditingController();
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:Constraints.getAppbar(context, Login(), 'Recovery Password'),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
          width: double.infinity,
          child: Form(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/images/forget_password_photo_1.png'),
                  SizedBox(height: 10),
                  Text('Please check your email to find verification code!'),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textAlign: TextAlign.start,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Enter Verificarion Code';
                      }
                    },
                    onSaved: (val){},
                    decoration: InputDecoration(
                      prefixIcon: Image.asset('asset/images/verify_icon.png'),
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      labelText:'Enter Verificarion Code',
                    )
                    ,
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade300
                    ),
                    child: FlatButton(child: Text('Confirm',style: _style1,),onPressed: ()=>
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_)=>RecoveryPassword2()))
                      ,),
                  ),
                  SizedBox(height: 30),
                  FlatButton.icon(onPressed: (){}, icon: Image.asset('asset/images/refresh_code.png'),
                      label: Text('Send verification code again',
                  style:Constraints.blueStyle ,) )


                ],
              )

          ),
        ),
      ),
    );
  }
  void confirmData(){

    if(!_formKey.currentState.validate()){
      return;
    }else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_)=>RecoveryPassword2()));
    }
  }

}
