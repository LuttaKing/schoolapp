
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/COMMON/common.dart';

class ReadStory extends StatefulWidget {
  final title;
  final image;
  final body;
  final index;

  const ReadStory({Key key, this.title, this.image, this.body, this.index}) : super(key: key);

  @override
  _ReadStoryState createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  bottomNavigationBar: BottomAppBar(
    color: Colors.white,
    child: _bottomButton(),
    elevation: 0.5,
  ),
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.close,color: Colors.white,),onPressed: (){Navigator.pop(context);},),),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
                  child: Column(children: [
   Hero(
     tag: widget.index,
        child: ClipRRect(borderRadius: BorderRadius.circular(10.0),
          child: Container(height: MediaQuery.of(context).size.height*0.37,width: MediaQuery.of(context).size.height*1,
                                            decoration: BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(widget.image),fit: BoxFit.fill)),
                                              
                                            ),
     ),
   ),

                                        Text(widget.title,style: TextStyle(fontSize: 30,color: Colors.blueGrey),),
                                        Divider(color: Colors.orange,endIndent: 10,indent: 10,),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(widget.body,style: TextStyle(letterSpacing: 1.0,fontSize: 20),),
                                        )
          ],),
        ),
      )),
      
    );
  }
  Widget _bottomButton(){
    return Padding(
      padding:  EdgeInsets.all(18.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
                      height:MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width*0.6,
                    child: FlatButton(
                      color: Colors.green,child: Text('CLOSE',
                      style: TextStyle(color: Colors.white,fontFamily: 'Ptsans',letterSpacing: 2),),
                      onPressed: (){
                    Navigator.pop(context);
                    },),),
                    SizedBox(
                      height:MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: FlatButton(
                      color: Colors.blue,child: Icon(Icons.thumb_up,color: Colors.white,),
                      onPressed: (){
                        tost('Story Liked');
                    Navigator.pop(context);
                    },),),
        ],
      ),
    );
  }
}