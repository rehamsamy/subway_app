
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_app/constraints.dart';
import 'package:subway_app/forget_password.dart';
import 'package:subway_app/home.dart';
import 'package:subway_app/services_api/services_api.dart';
import 'package:toast/toast.dart';

import 'register.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> _key=GlobalKey();

  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  bool _checked=true;
  @override
  Widget build(BuildContext context) {
   // setDataInPreferences();

    return Scaffold(
      body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              width: double.infinity,
              child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Image.asset('asset/images/forget_password_photo_1.png'),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textAlign: TextAlign.start,
                        validator: (val) {
                          if (val.isEmpty || !val.contains('@')) {
                            return 'Enter Valid Email';
                          }
                        },
                        onSaved: (val) {},
                        decoration: InputDecoration(
                          prefixIcon:
                              Image.asset('asset/images/signin_email.png'),
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          labelText: 'Enter Email',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: true,
                        textAlign: TextAlign.start,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter Password';
                          }else if(val.length<6){
                            return 'Password is too weak';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Password',
                          prefixIcon:
                              Image.asset('asset/images/signin_password.png'),
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
                                    child: FlatButton(child: Text('Log In ',style: _style1,),onPressed:()async{
                                      await loginWithData(_emailController,_passwordController);
                                      print('xxxxxxxxxx');
                                    }
                                  ),),
                                  SizedBox(height: 15),
                                  Container(
                                    width: double.infinity,
                                    height: 42,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.shade300
                                    ),
                                    child: FlatButton(child: Text('Sign Up',style: _style1,),onPressed: ()=>
                                      Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_)=>Register())),),
                                  ),
                                  SizedBox(height: 10,),
                                  FlatButton(onPressed: ()=>
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_)=>ForgetPassword()))
                                      , child: Text('Forget Password ?'))

                    ]),
                  )))
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Future loginWithData(TextEditingController c_email,TextEditingController c_password)async{
    if(!_key.currentState.validate())
    return;

    SharedPreferences _prefs=await SharedPreferences.getInstance();
    var email=_prefs.getString('email');
    var password=_prefs.getString('password');

    print('email ... ${email} .... pass ....${password}');
    Map<String,String> map={'USER_NAME':'MOATASEM1','PASSWORD':'123'};
   Constraints.getProgress(context);
    var x=await ServicesApi.loginApi(map);
    print('fffffff ${x.toString()}');
   if(x==0){
     Toast.show('invalid Email or password', context,duration: Toast.LENGTH_LONG);
   }else{
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyHome()));
     await setDataInPreferences(c_email.text,c_password.text);
   }

  }


}

setDataInPreferences(String email,password)async{
  SharedPreferences _prefs=await SharedPreferences.getInstance();
  _prefs.setString('email', 'ahmed@123.com');
  _prefs.setString('password', '123');
  print(_prefs.getString('email'));
}