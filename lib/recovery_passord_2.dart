import 'package:flutter/material.dart';
import 'package:subway_app/recovery_password_1.dart';

import 'constraints.dart';
import 'home.dart';
import 'login.dart';

class RecoveryPassword2 extends StatefulWidget {


  @override
  _RecoveryPassword2State createState() => _RecoveryPassword2State();
}

class _RecoveryPassword2State extends State<RecoveryPassword2> {

  GlobalKey<FormState> _formKey=GlobalKey();
  var _passwordController=TextEditingController();
  var _ConfirmPasswordController=TextEditingController();
  TextStyle _style1 = TextStyle(fontSize: 18, color: Colors.white);
  var _icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:Constraints.getAppbar(context, RecoveryPassword1(), 'Recovery Password'),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          width: double.infinity,
          child: Form(
            key: _formKey,
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/images/forget_password_photo_2.png'),
                  SizedBox(height: 10),
                  Text('Please enter new password'),
                  SizedBox(height: 10),

                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.start,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Enter Password';
                      }else if(val.length<6){
                        return 'Password is too short';
                      }

                    },
                    decoration: InputDecoration(
                      labelText:'Enter Password',
                      prefixIcon: Image.asset('asset/images/signup_password.png'),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _ConfirmPasswordController,
                    obscureText: true,
                    textAlign: TextAlign.start,
                    validator: (val){
                      if(val.isEmpty){
                        return 'Confirm Password';
                      }else if(_passwordController.text==val&& val.length>6){
                        setState(() {
                          _icon=Image.asset('asset/images/signup_confirm_password.png');
                          return 'password match';
                        });
                      }else if(_passwordController.text!=val){
                        return 'Password not match';
                      }
                    },
                    decoration: InputDecoration(
                        labelText:'Enter Confirm Password',
                        prefixIcon: Image.asset('asset/images/signup_password.png'),
                        suffixIcon: _icon
                    ),
                  ),

                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade300
                    ),
                    child: FlatButton(
                      child: Text('Confirm', style: _style1,), onPressed: confirmData
                      ,),
                  ),
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
    }
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_)=>MyHome()));
  }
}
