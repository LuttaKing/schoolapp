import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PicScreen extends StatefulWidget {

  final String imageurl;
  final String herotag;

  PicScreen({this.imageurl,this.herotag});
  @override
  _PicScreenState createState() => _PicScreenState();
}

class _PicScreenState extends State<PicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: GestureDetector(

        child:Center(child: Hero(tag:widget.herotag,child: CachedNetworkImage(imageUrl: widget.imageurl)),),
      onTap: (){
        Navigator.pop(context);
      },
      ),
      
    );
  }
}