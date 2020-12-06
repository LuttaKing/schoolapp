import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/COMMON/common.dart';
import 'package:schoolapp/Screens/DrawerPage.dart';

class FactScreen extends StatefulWidget {
  @override
  _FactScreenState createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
bool isLoading=false;
FirebaseFirestore firestore = FirebaseFirestore.instance;
   
    var someStream;
   @override
  void initState() {
   fetchFacts('Psychology');
     super.initState();
       someStream= firestore.collection('principal').snapshots();
  }
  List factList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
        appBar: AppBar(leading: IconButton(
              icon: Icon(Icons.menu,color:Colors.black,size: 33,), 
            onPressed: () {  
                                ZoomDrawer.of(context).toggle();

          
            },),
            backgroundColor: Colors.white ,
            elevation: 1,actions: <Widget>[

                 IconButton(icon: Icon(Icons.close,color:Colors.black,size: 33,), onPressed: () {  
                   Navigator.pop(context);
                 },),
            ],),
            body: SingleChildScrollView(
                          child: Container(child: Column(children: [
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
                                       padding: const EdgeInsets.all(12.0),
                                       child: Text('Dose of Facts',style: TextStyle(color: Colors.indigo,fontSize: 26,fontFamily: 'Fred'),),
                                     ),
 
                            isLoading ? Center(child: CircularProgressIndicator()):
                          factList!=null?  ListView.builder(
                                 physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
            itemCount: factList.length,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.only(top:7.0,bottom: 5,left: 21,right: 21),
              child: Stack(
                children: [
                  Card(elevation: 2,color: Colors.white,child: Container(color: Colors.white,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.only(top:25.0,bottom: 25,left: 13,right: 13),
                    child: Text(factList[index],style: TextStyle(fontFamily: 'Nunito',fontSize: 17),),
                  )),)),

                  Positioned(top: 6,right: 6,child: IconButton(icon: Icon(Icons.share,color: Colors.orange,),
                  onPressed: (){
                    Share.share(factList[index]);
                  },),),
                                    Positioned(bottom: 6,right: 6,child: IconButton(icon: Icon(Icons.file_copy,color: Colors.orange,)
                                    ,onPressed: ()async{
                                      await Clipboard.setData(ClipboardData(text: factList[index]));
                                      tost('Copied');
                                    },),)

                ],
              ),
            );
          }
                            ):Text('List empty')
                
              ],),),
            ),
      
    );
  }

    Future fetchFacts(String tagname) async {
      setState(() {isLoading=true;});
        try {
          var url = 'https://factsproject.herokuapp.com/api/1/fact';
          
          var response = await http.post(url, body: {'tag':tagname,},headers: {'key':'LuttaIsAwesome369'});

          if(response.body.contains('Page Does Not Exist')){
              print('PAGE NOT FOUND');
          }else{
            List returned = json.decode(response.body);
           
            returned.shuffle();
            List innerfactlist=[];
                    for (var item in returned) {
                      String imageLink=item['fields']['image_link'];
                      String factBody=item['fields']['fact_body'];
                      innerfactlist.add(factBody);
                 
            
                    }   
                    setState(() {
               
                      factList=innerfactlist;
                    });
                    
                    }
                  
        } catch (e) {
         tost(e.toString()); 
    
        }
        setState(() {isLoading=false;});
}
}

class FactScreenDrawer extends StatefulWidget {
  final tagname;
  FactScreenDrawer({this.tagname});
  @override
  _FactScreenDrawerState createState() => _FactScreenDrawerState();
}

class _FactScreenDrawerState extends State<FactScreenDrawer> {
      final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return  ZoomDrawer(
      angle: 0,
      controller: _drawerController,
      menuScreen: MyDrawer(drawerController: _drawerController,),
      mainScreen: FactScreen(),
      borderRadius: 10.0,
      showShadow: false,
      slideWidth: MediaQuery.of(context).size.width*.64,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeInCubic,
    );
  }
}