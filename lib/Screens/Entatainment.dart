import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:schoolapp/COMMON/common.dart';
import 'package:show_up_animation/show_up_animation.dart';

class EntataimentPage extends StatefulWidget {
  @override
  _EntataimentPageState createState() => _EntataimentPageState();
}

class _EntataimentPageState extends State<EntataimentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child:SingleChildScrollView(
              child: Container(child: ShowUpList(children: [
Padding(
  padding: const EdgeInsets.all(60.0),
  child:   Text('All forms of entertainment',style: TextStyle(fontSize: 30),),
),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Facebook'),entatainItem('Whatsapp'),entatainItem('TikTok')],),
          SizedBox(height: 50,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Music'),entatainItem('Instagram'),entatainItem('Twitter')],),
                    SizedBox(height: 50,),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Pinterest'),entatainItem('Youtube'),entatainItem('Test')],),
                    SizedBox(height: 120,),

closeBtn(),

        ],),),
      ),),
      
    );
  }
Widget closeBtn(){
  return  Center(
    child: SizedBox(
                            width: 200,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                                color:   Colors.pink[500],)),
  );
}



}