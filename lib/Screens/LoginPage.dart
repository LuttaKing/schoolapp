import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/MainFolder/myapp.dart';
import 'package:schoolapp/COMMON/loginFunctions.dart';
import 'package:show_up_animation/show_up_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String password='';
  String name='';
  bool isLoading=false;
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                              SizedBox(   height:MediaQuery.of(context).size.height*0.09,),

             logo(),
                                             SizedBox(   height:MediaQuery.of(context).size.height*0.09,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
               Container(decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),),
                child: TextFormField(
      
                   validator: (val)=> val.length<3 ? 'Enter Valid Username' : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person,color:Color(0xffb1a6ca),),
                  labelText: ' Username',
                  labelStyle: TextStyle(fontSize: 14,fontFamily: 'QuickBold',fontWeight: FontWeight.bold),
                ),
                onChanged: (val){
                  setState(() {
                    name=val;
                  });
                },
                ),
              ),
                              SizedBox(   height:MediaQuery.of(context).size.height*0.03,),

                     Container(decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),),
                child: TextFormField(
                   validator: (val)=> val.length <=0 ? 'Enter Valid Password' : null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.vpn_key,color:Color(0xffb1a6ca),),
                  labelText: ' Password',
                  labelStyle: TextStyle(fontSize: 14,fontFamily: 'QuickBold',fontWeight: FontWeight.bold),
                
                ),
                onChanged: (val){
                  setState(() {
                    password=val;
                    
                  });
                },
                ),
              ),
           
                              SizedBox(   height:MediaQuery.of(context).size.height*0.08,),

                  ]),
                ),
              ),
        
              isLoading ?
             
               loadingButton()
              :
               ShowUpAnimation(
                          delayStart: Duration(milliseconds:200),
  animationDuration: Duration(milliseconds: 500),
  curve: Curves.bounceInOut,
  direction:Direction.vertical,
  offset: 0.2,
                                child: Center(
                  child: SizedBox(
                    width: 280,
                    height: 45,
                    child: RaisedButton(
                        color:   Color(0xffF07A3E),
                        child: Text('Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold
                            )),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0),
                        ),
                        onPressed: () async{ 
                          // if(_formKey.currentState.validate()){
                          //     setState(() {
                          //       isLoading=true;
                          //     });

                               await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyPage(),
        ),
      );

                      //    }
                              
                        }
                        ),
                  ),
              ),
               ),
                            SizedBox(   height:MediaQuery.of(context).size.height*0.15,),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only( top: 56),
                  child: RichText(
                    text: TextSpan(
                        text: 'Having issues ? ',
                        style: TextStyle(
                          color: Colors.black,
                       fontFamily: 'QuickBold',
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Go To Portal',
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {

                              
                               
                              },
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                             
                               color: Color(0xffbd4041),
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

}