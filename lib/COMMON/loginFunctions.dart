import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';




Widget logo(){
  return  ShowUpAnimation(
              delayStart: Duration(milliseconds:380),
                        animationDuration: Duration(milliseconds: 400),
                        curve: Curves.bounceInOut,
                        direction:Direction.vertical,
                        offset: -0.2,
      child: Container(child: Image.asset('assets/logo.png'),),
  );
}

Widget loadingButton(){
  return Center(
                child: SizedBox(
                  width: 280,
                  height: 45,
                  child: RaisedButton(
                      color: Colors.grey[200],
                      child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 2,),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(35.0),
                      ),
                      onPressed: (){},
                      ),
                ),
              );
}