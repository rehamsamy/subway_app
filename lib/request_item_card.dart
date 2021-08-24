import 'package:flutter/material.dart';
import 'package:subway_app/models/request.dart';
import 'package:toast/toast.dart';


class RequestItemCard extends StatelessWidget {
  RequestModel requestModel;
  RequestItemCard(this.requestModel);





  @override
  Widget build(BuildContext context) {
    String image='asset/images/wishlist_not_select.png';
    return   Card(
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
                child: IconButton(icon: Image.asset(image),onPressed: (){
                  // setState(() {
                    if(image=='asset/images/wishlist_not_select.png'){
                      image='asset/images/wishlist_select.png';
                      Toast.show('add to favorite', context,duration:Toast.LENGTH_LONG);
                    }else{
                      image='asset/images/wishlist_not_select.png';
                      Toast.show('remove from favorite', context,duration:Toast.LENGTH_LONG);
                    }
                    Navigator.pop(context);
                  // });
                },)
            ),
            Positioned(
                left: 5,
                bottom: 10,child: Text(requestModel.description,style: TextStyle(color: Colors.black),))
          ],
        ) ,
      ),
    );
  }
}

