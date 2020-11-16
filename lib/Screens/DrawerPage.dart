
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:schoolapp/COMMON/common.dart';
import 'package:schoolapp/Screens/ClassChat.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:url_launcher/url_launcher.dart';


class MyDrawer extends StatefulWidget {
  final drawerController;
  MyDrawer({this.drawerController});
 
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      
      body: SafeArea(
              child: Container(
            color: Color(0xfff5f6fa),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Row(children: [drawerHeader()],),
              SizedBox(height: 20,),


                listTile('Home',Icons.home,Colors.indigo,context),
                listTile('My Units',Icons.account_box,Colors.indigo,context),
               listTile('Fee Detail',Icons.card_membership,Colors.indigo,context),
              
             listTile('Class Chat',Icons.monetization_on,Colors.indigo,context),
              listTile('School Forum',Icons.info,Colors.indigo,context),
               Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child: Divider(indent: 20,
                                  endIndent: 20,color:Colors.indigo,),
                ),
               listTile('Rate App',Icons.rate_review,Colors.indigo,context),
         
                              listTile('Log Out',Icons.logout,Colors.indigo,context),

SizedBox(height: 40,),

           
               
              ],
            ),
        ),
      ),
    );
     
  }

  Widget listTile(String title, IconData icon,Color color,BuildContext context){
    return ListTile(
            title: Text(title,style: TextStyle(fontFamily: 'Nunito' ,color: Colors.blueGrey ,fontSize: 19)),
            leading: Icon(icon,color: color),
            onTap: () {
              if (title=='Home') {
                widget.drawerController.toggle();
               
              } else if(title=='My Units'){
                widget.drawerController.toggle();
             
              }else if(title=='Fee Detail'){
                           widget.drawerController.toggle();

              }
            
              else if(title=='Class Chat'){
                widget.drawerController.toggle();
                Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassChat(userid: 'Kisiomi',isClass: true,),
        ),
      );
              
              }
               else if(title=='School Forum'){
                widget.drawerController.toggle();
                    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassChat(userid: 'Kisiomi',isClass: false,),
        ),
      );
              
              }
              else if(title=='Rate App'){
                widget.drawerController.toggle();
              openRatingBoard(context);
          
              }
              else if(title=='Log Out'){
                widget.drawerController.toggle();
              tost('Logging out');
          
              }
             
            },
          );
  }

  Widget drawerHeader(){
    return       Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(radius: 30,backgroundColor: Color(0xffF07A3E),child: CircleAvatar(radius: 28,
          child: Icon(Icons.person),
        )),
          SizedBox(height: 6,),
         Text('Brian Kisiomi'.toUpperCase(),style: TextStyle(fontSize: 17,fontFamily: 'Ptsans'),),
                   SizedBox(height: 2,),

         Text('Kisiomi@gmail.com',style: TextStyle(fontSize: 13,fontFamily: 'QuickBold',fontWeight: FontWeight.bold),),

        ],
      ),
    );
  }

  void sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'TrukFinder@gmail.com',
    );
    String  url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
      tost('Feel free to reach us @ TrukFinder@gmail.com');
    } else {
      print( 'Could not launch $url');
    }

  }

  openRatingBoard(BuildContext context){

  Widget okButton = FlatButton(
    color: Colors.blueGrey,
    child: Text(" Close "),
    onPressed: () { 
      Navigator.of(context).pop();
    },
  );

  
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Center(child: Text("Do you like the app",style: TextStyle(color: Colors.black,
    fontFamily: 'Nunito',fontSize: 20),)),
    content:   Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RatingBar(
        onRatingChanged: (rating){},
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        filledColor: Colors.orange,
        emptyColor: Colors.blueGrey,
   
        size: 40,
  ),

  Padding(
    padding: const EdgeInsets.only(top:10.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[Text('You are awesome ',style: TextStyle(color: Colors.blueGrey,fontFamily: 'Ptsans',fontSize: 14)),
    ShowUpAnimation(
       delayStart: Duration(milliseconds:700),
  animationDuration: Duration(milliseconds: 600),
  curve: Curves.bounceInOut,
  direction:Direction.vertical,
  offset: 0.2,
      child: Icon(Icons.favorite,color: Colors.pink,))
    ],),
  )
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return       alert;
    },
  );

  }

}