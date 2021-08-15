import 'package:flutter/material.dart';
import 'package:subway_app/login.dart';
import 'package:subway_app/recovery_password_1.dart';

import 'constraints.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  GlobalKey<FormState> _formKey=GlobalKey();
  var _emailController=TextEditingController();
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:Constraints.getAppbar(context, Login(), 'Forget Password'),
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              width: double.infinity,
              child: Form(
                key: _formKey,
                child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('asset/images/forget_password_photo_1.png'),
                        SizedBox(height: 10),
                        Text('Please enter your email!'),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          textAlign: TextAlign.start,
                          validator: (val){
                            if(val.isEmpty||!val.contains('@')){
                              return 'Enter Valid Email';
                            }
                          },
                          onSaved: (val){},
                          decoration: InputDecoration(
                            prefixIcon: Image.asset('asset/images/signin_email.png'),
                            contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            labelText:'Enter Email',
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
                          child: FlatButton(child: Text('Confirm',style: _style1,),onPressed: confirmData
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
        MaterialPageRoute(builder: (_)=>RecoveryPassword1()));
  }
}
