import 'package:flutter/material.dart';
import 'package:subway_app/models/request.dart';
import 'package:toast/toast.dart';


class RequestItemCard extends StatefulWidget {
  RequestModel requestModel;
  RequestItemCard(this.requestModel);

  @override
  _RequestItemCardState createState() => _RequestItemCardState();
}

class _RequestItemCardState extends State<RequestItemCard> {

  String image='asset/images/wishlist_not_select.png';

  @override
  Widget build(BuildContext context) {
    return   Card(
      margin: EdgeInsets.all(10),
      child: Container(
        child:Stack(
          children: [
            Image.asset('asset/images/home_photo.png',fit: BoxFit.cover),
            Positioned(
                right: 5,
                bottom: 10,
                child: Text(widget.requestModel.price.toString(),style: TextStyle(color: Colors.green),)),
            Positioned(left: 0,
                top: 0,
                child: IconButton(icon: Image.asset(image),onPressed: (){
                  setState(() {
                    if(image=='asset/images/wishlist_not_select.png'){
                      image='asset/images/wishlist_select.png';
                      Toast.show('add to favorite', context,duration:Toast.LENGTH_LONG);
                    }else{
                      image='asset/images/wishlist_not_select.png';
                      Toast.show('remove from favorite', context,duration:Toast.LENGTH_LONG);
                    }
                  });
                },)
            ),
            Positioned(
                left: 5,
                bottom: 10,child: Text(widget.requestModel.description,style: TextStyle(color: Colors.black),))
          ],
        ) ,
      ),
    );
  }
}

