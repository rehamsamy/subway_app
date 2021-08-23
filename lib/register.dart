
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subway_app/constraints.dart';
import 'package:subway_app/login.dart';
import 'package:subway_app/services_api/services_api.dart';
import 'package:toast/toast.dart';

import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<FormState> _formKey=GlobalKey();

  TextStyle _style1=TextStyle(fontSize: 18,color: Colors.white);


  var _nameController=TextEditingController();
  var _passwordController=TextEditingController();
  var _emailController=TextEditingController();
  var _ConfirmPasswordController=TextEditingController();
   var _phoneController=TextEditingController();
      var _icon;
      File _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constraints.getAppbar(context, Login(), 'Create New Account'),
      body:Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
          width: double.infinity,
          child: Form(
            key: _formKey,
              child:
          SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('asset/images/signup_photo_1.png'),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.start,
                  validator: (val){
                    if(val.isEmpty){
                      return 'Enter your name';
                    }
                  },
                  onSaved: (val){},
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('asset/images/signup_name.png'),
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    labelText:'User Name',
                  )
                  ,
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _phoneController,
                  textAlign: TextAlign.start,
                  validator: (val){
                    if(val.isEmpty){
                      return 'Enter your phone';
                    }else if(val.length<11){
                      return 'phone number is invalid';
                    }
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (val){},
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('asset/images/signup_phone.png'),
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    labelText:'Phone Number',
                  )
                  ,
                ),
                SizedBox(height: 5),
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
                SizedBox(height: 5,),
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
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _ConfirmPasswordController,
                  obscureText: true,
                  textAlign: TextAlign.start,
                  validator: (val){
                    if(val.isEmpty){
                      return 'Confirm Password';
                    }else if(_passwordController.text==val){
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
                SizedBox(height: 10),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: ListTile(onTap:()async=> await getIdPhoto(),trailing:Image.asset('asset/images/upload_photo.png'),title: Text('upload national id photo'),),
                 ) ,
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade300
                  ),
                  child: FlatButton(child: Text('Confirm',style: _style1,),onPressed: registerData
                 ,),
                ),
              ],
            ),
          )),


        ),
      ),
    );
  }

  void registerData()async{
    Map<String,String> map={'USER_NAME':_nameController.text,
                            'PASSWORD':_passwordController.text,
                             'PHONE':_phoneController.text ,
                             'ID_IMAGE':_image.path,
                               'EMAIL':_emailController.text,
                              'DEVICE_IP':'',
                              'FINGER':''};
   if(! _formKey.currentState.validate()){
     return;
   }else if(_image==null){
     Toast.show('please you must choose national id photo', context,duration: Toast.LENGTH_LONG);
   }else{
     Constraints.getProgress(context);
     var result=await ServicesApi.registerUser(map);
     if(result.toString()=='User Created'){
       Toast.show(result.toString(), context,duration: Toast.LENGTH_LONG);
       Navigator.push(context, MaterialPageRoute(builder: (_)=>MyHome()));
     }else{
       Toast.show(result.toString(), context,duration: Toast.LENGTH_LONG);
     }

   }

  }

  getIdPhoto()async {
    ImagePicker _picker=ImagePicker();
  var path=  await _picker.pickImage(source: ImageSource.gallery);
  if(path !=null){
    _image=File(path.path);
    print(_image);
  }
  }

}

