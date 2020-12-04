import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/COMMON/common.dart';
import 'package:schoolapp/Screens/Entatainment.dart';
import 'package:schoolapp/COMMON/loginFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/Screens/ReadStoryPage.dart';
import 'package:schoolapp/VideoCall/CallPage.dart';
import 'package:schoolapp/VideoCall/LobbyPage.dart';
import 'package:schoolapp/notifier/notifier.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference someCollection = FirebaseFirestore.instance.collection('stories');
    var someStream;
  @override
  void initState() {
    super.initState();
     getStories();

     someStream= firestore.collection('principal').snapshots();
  }
List storiesList;
 void getStories()async {
   QuerySnapshot querySnapshot=await someCollection.get();
setState(() {
  storiesList=querySnapshot.docs;
});
}
  @override
  Widget build(BuildContext context) {
     return Consumer<MyNotifier>(builder: (context, myNotifier, anything) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: (){
          ZoomDrawer.of(context).toggle();
      },),actions: [
        IconButton(icon: Icon(Icons.tap_and_play_sharp,color: Colors.white,),
        onPressed: ()async{await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntataimentPage(), ),
      );
        },),
          IconButton(icon: Icon(Icons.call,color: Colors.white,),
        onPressed: ()async{
          await requestCameraAndMic();
                             await Navigator.push(context,MaterialPageRoute(
          builder: (context) => CallPage(
              channelName: 'principal',
            role: ClientRole.Broadcaster,
          ),
        ),
      );
        },),
      ],),
            backgroundColor: Colors.grey[100],

      body: ListView(children: [

        StreamBuilder<QuerySnapshot>(
                stream:someStream,
                   builder: (context, snapshot) {
                     if (!snapshot.hasData)
                    return Container();
//print(snapshot.data.docs[0].data()['meeting']);

if (snapshot.data.docs[0].data()['meeting']=='on'){
 return joinMeeting(context);
}
else{
  return Container();
}
                   }),

                      SizedBox(   height:MediaQuery.of(context).size.height*0.04,),

       logo(),
      SizedBox(   height:MediaQuery.of(context).size.height*0.06,),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Trending Stories',style: TextStyle(color: Colors.indigo,fontSize: 26,fontFamily: 'Fred'),),
          IconButton(onPressed:(){
            getStories();
          } ,icon: Icon(Icons.refresh,color: Colors.indigo,),)
        ],
      ),
                      SizedBox(   height:MediaQuery.of(context).size.height*0.03,),

storiesList!=null ? Padding(
  padding: const EdgeInsets.all(2.0),
  child:   Container(
    height: 700,
    child: ListView.builder( 
      physics: NeverScrollableScrollPhysics(),
      itemCount: storiesList.length, 
      itemBuilder: (BuildContext context,int index){ 
        return _storyTile(storiesList[index],index); 
      } 
      ),
  ),
):CircularProgressIndicator(strokeWidth: 2,)


        ],),
      
    );
       });
  }
  
  Widget _storyTile(var story,int index){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
              child: Card( shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
  ),
                              child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
                child: Container(height: 105,width: 400,color: Colors.white,
        
          child: Row(children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Hero(
                  tag:index.toString(),
                                child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Container(height: 70,width: 70,
                                          decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(story['image']),fit: BoxFit.fill)),
                                            
                                          )),
                ),
            ),

                      Container(width: 240,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15,),
                          Text(story['title'],style: TextStyle(color: Colors.blueGrey,fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 18),),
                          Text(story['body'],
                          textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis,
                          maxLines: 3,),
                        ],),
                      )
          ],),),
        ),
              ),
        onTap: (){
               Navigator.push(context,MaterialPageRoute(
          builder: (context) => ReadStory(body: story['body'],title: story['title'],
          image:story['image'] ,index: index.toString(),),
        ),
      );
        },
      ),
    );
  }
}
