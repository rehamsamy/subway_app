
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:subway_app/constraints.dart';
import 'package:subway_app/forget_password.dart';
import 'package:subway_app/home.dart';
import 'package:subway_app/services_api/my_provider.dart';
import 'package:subway_app/services_api/services_api.dart';
import 'package:toast/toast.dart';

import 'register.dart';


class Login extends StatelessWidget {

  static String x;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create :(_)=>MyProvide(),child:Login1() ,);
  }




}


class Login1 extends StatefulWidget {
  static String user_serial;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login1> {

  GlobalKey<FormState> _key=GlobalKey();
  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);
  var _emailController=TextEditingController();
  var _passwordController=TextEditingController();
  bool _checked=true;
  @override
  Widget build(BuildContext context) {
   // setDataInPreferences();

    return
    //   ChangeNotifierProvider(  create :(_)=>MyProvide(),
    // child:
      Scaffold(
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

   // print('email ... ${c_email.text} .... pass ....${_passwordController.text}');

    Map<String,String> map={'USER_NAME':c_email.text,'PASSWORD':_passwordController.text};
   Constraints.getProgress(context);
    var x=await ServicesApi.loginApi(map);
    print('fffffff ${x.toString()}');
  //  print ('provideee  ${Provider.of<MyProvide>(context,listen: true).userSerialNum}');
  if(x=='Please Check user name and password'){
     Toast.show(x, context,duration: Toast.LENGTH_LONG);
     Future.delayed(Duration(seconds: 30));
     Navigator.pop(context);


  }else{
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyHome()));
    // Provider.of<MyProvide>(context,listen: true).setUserSerial(x);
     await setDataInPreferences(c_email.text,c_password.text);
     Login.x=x;
     print(Login.x);
  }

  }




}



setDataInPreferences(String email,password)async{
  SharedPreferences _prefs=await SharedPreferences.getInstance();
  _prefs.setString('email', 'ahmed@123.com');
  _prefs.setString('password', '123');
  print(_prefs.getString('email'));
}