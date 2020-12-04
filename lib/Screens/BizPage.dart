import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/COMMON/common.dart';
import 'package:schoolapp/Screens/AddSellItem.dart';
import 'package:url_launcher/url_launcher.dart';

class BizPage extends StatefulWidget {
  @override
  _BizPageState createState() => _BizPageState();
}

class _BizPageState extends State<BizPage> {
 
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference someCollection = FirebaseFirestore.instance.collection('shop');
    @override
  void initState() {
    super.initState();
     getShop();
  }
List shopObjects;
 void getShop()async {
   QuerySnapshot querySnapshot=await someCollection.get();
setState(() {
  shopObjects=querySnapshot.docs;
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Buy and Sell'),),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.orange,
          onPressed: (){
            Navigator.push(
                                context,
                                 MaterialPageRoute(
                                 builder: (context) => AddSellItem(),
                 ));
          },
          label: Text('Sell',style: TextStyle(color: Colors.white,fontFamily: 'New'),),
          icon: Icon(Icons.photo_camera,color: Colors.white,),
        ), 
        body: SafeArea(
                  child: Container(      color: Colors.grey[200],
          child: SingleChildScrollView(
                    child: Column(        crossAxisAlignment: CrossAxisAlignment.start,
children: [
  SizedBox(   height:MediaQuery.of(context).size.height*0.06,),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Top Items',style: TextStyle(color: Colors.indigo,fontSize: 26,fontFamily: 'Fred'),),
          IconButton(onPressed:(){
            getShop();
          } ,icon: Icon(Icons.refresh,color: Colors.indigo,),)
        ],
      ),
                      SizedBox(   height:MediaQuery.of(context).size.height*0.03,),
 shopObjects!=null ? gridView():CircularProgressIndicator(strokeWidth: 2,),

            ],),
          ),
),
        ),
      );
    
  }
  Widget gridView(){
   return ListView.builder(
             physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
            itemCount: shopObjects.length,
          itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding: const EdgeInsets.only(left:16.0,right: 16.0,top: 7.5,bottom: 4),
                  child: Container(height: MediaQuery.of(context).size.height*0.25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                        ),
                  child: Stack(
                  
                    children: <Widget>[
               
                    Container( height: MediaQuery.of(context).size.height*0.178,
                    decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft:Radius.circular(12),topRight: Radius.circular(12)),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                            image: CachedNetworkImageProvider(shopObjects[index]['image']),
                                            fit: BoxFit.fill,  ),
                                        )),

                       Positioned(top: 15,left: 11,child: 
                       Container(decoration: BoxDecoration(color: Colors.blue[700],borderRadius: BorderRadius.all(Radius.circular(10))),child: Padding(
                         padding: const EdgeInsets.all(2.0),
                         child: Text(shopObjects[index]['price']+' Kes',style: TextStyle(fontSize: 16,fontFamily: 'Ptsans',color: Colors.white)),
                       ))),

                       Positioned(bottom: 28,left: 11,child: Text(shopObjects[index]['name'],style: TextStyle(fontSize: 17),)),

                       Positioned(bottom: 3,left: 11,
                                                  child: Row(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.phone_android,color: Colors.redAccent,size: 13,),
                                Text(shopObjects[index]['number'],style: TextStyle(color: Colors.grey,fontSize: 10),),
                              ],
                            ),

                            SizedBox(width: 20,),

                         Row(
                           children: <Widget>[
                             
                             Icon(Icons.keyboard,color: Colors.redAccent,size: 13,),
                             Text('',
                             style: TextStyle(color: Colors.grey,fontSize: 11)),
                           ],
                         ),
                         ],),
                       ) ,
                       Positioned(top:3,right: 8,child: CircleAvatar(
                         backgroundColor: Colors.grey.withOpacity(0.48),
                         child: IconButton(icon: Icon(Icons.call,size: 17,
                         color: Colors.white,),onPressed: (){
                           launchCaller(shopObjects[index]['number']);
                         },))),

                       Positioned(right: 8,bottom: 0,child: IconButton(
                         icon: Icon(Icons.favorite,
                         color: Colors.redAccent,),onPressed:(){
                                            tost('Liked item');         
                         },))                

                  ],),),
                );
          },);
  }
  launchCaller(String phone) async {
    var url = "tel:$phone";   
    if (await canLaunch(url)) {
       await launch(url);
    } else {
      throw 'Could not launch $url';
    }   
}
}