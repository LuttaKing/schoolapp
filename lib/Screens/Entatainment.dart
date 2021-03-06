import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/COMMON/common.dart';
import 'package:show_up_animation/show_up_animation.dart';

class EntataimentPage extends StatefulWidget {
  @override
  _EntataimentPageState createState() => _EntataimentPageState();
}

class _EntataimentPageState extends State<EntataimentPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
    var someStream;
   void initState() {
    super.initState();
   
 
     someStream= firestore.collection('principal').snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(centerTitle: true,title: Text('Pick a gig'),),
      body: SafeArea(child:SingleChildScrollView(
              child: Container(child: ShowUpList(children: [
                 StreamBuilder<QuerySnapshot>(
                stream:someStream,
                   builder: (context, snapshot) {
                     if (!snapshot.hasData)
                    return Container();

if (snapshot.data.docs[0].data()['meeting']=='on'){
 return joinMeeting(context);
}
else{
  return Container();
}
                   }),
Padding(
  padding: const EdgeInsets.all(60.0),
  child:   Text('All forms of entertainment',style: TextStyle(fontSize: 30),),
),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Facebook'),entatainItem('Whatsapp'),entatainItem('TikTok')],),
          SizedBox(height: 40,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Music'),entatainItem('Instagram'),entatainItem('Twitter')],),
                    SizedBox(height: 40,),

          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [entatainItem('Pinterest'),
          entatainItem('Youtube'),entatainItem('Quotes')],),
           SizedBox(height: 40,),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [entatainItem('Memes'),],),
                    SizedBox(height: 20,),

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