import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolapp/chatFolder/chatWidgets.dart';

class ClassChat extends StatefulWidget {
    final String userid;
    final bool isClass;

 ClassChat({this.userid, this.isClass});
  @override
  _ClassChatState createState() => _ClassChatState();
}

class _ClassChatState extends State<ClassChat> {
FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController messageContrl = TextEditingController();
  ScrollController scrollController = ScrollController();

  File imageFile;
  bool isLoading;
  var classStream;
  var schoolStream;

  bool isUploadingImage = false;
  String imageUrl;
String className='TestClass';
  final FirebaseStorage _storage =FirebaseStorage(storageBucket: 'gs://schoolapp-756e6.appspot.com');
  StorageUploadTask _uploadTask;
  Future _startUpload() async {
    isUploadingImage = true;
    if (widget.isClass) {
      String filePath = '$className images/${DateTime.now()}.png';
      //upload image
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
    } else {
      String filePath = 'SchoolForum images/${DateTime.now()}.png';
      //upload image
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
    }
    
    // get Url
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    String picUrl = await taskSnapshot.ref.getDownloadURL();

    // private code i wrote to clear uploadtask on complete
    _uploadTask.onComplete.then((val) {
      setState(() {
        _uploadTask = null;
        imageFile = null;
      });
    });
    isUploadingImage = false;
    return picUrl;
  }
  
    Future<void> callback() async {
//if no file selected
    if (imageFile == null) {
      if (messageContrl.text.length > 0) {
 
       if(widget.isClass){
          await firestore.collection(className).add({
          'text': messageContrl.text,
          'from': widget.userid.toString(),
          'date': Timestamp.now(),
        });
       }else{
          await firestore.collection('School Forum').add({
          'text': messageContrl.text,
          'from': widget.userid.toString(),
          'date': Timestamp.now(),
        });
       }
        messageContrl.clear();
       

        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
//if file selected upload it

      await _startUpload().then((picUrl) async {
//after upload post link
   if(widget.isClass){
        await firestore.collection(className).add({
          'text': picUrl,
          'from': widget.userid.toString(),
          'date': Timestamp.now(),
        });
       }else{
         await firestore.collection('School Forum').add({
          'text': picUrl,
          'from': widget.userid.toString(),
          'date': Timestamp.now(),
        });
       }
       
      });
    }
  }
  @override
  void initState() {
    super.initState();
    classStream= firestore.collection(className).orderBy('date').snapshots();
 schoolStream= firestore.collection('School Forum').orderBy('date').snapshots();
    isLoading = false;
    isUploadingImage = false;
  }
  Future pickImage() async {
    File selectedimage =await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      isLoading = true;
      imageFile = selectedimage;
    });
  }

  @override
  Widget build(BuildContext context) {
     // https://stackoverflow.com/questions/43485529/programmatically-scrolling-to-the-end-of-a-listview

    
      Timer(Duration(milliseconds: 1000),
          () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return Scaffold(
            backgroundColor: Color(0xfff5f6fa),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(widget.isClass? className:'School Forum',style: TextStyle(fontFamily: 'Ptsans', 
          fontSize: 18, fontWeight: FontWeight.w300),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
     
            child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            isUploadingImage
                ? LinearProgressIndicator(backgroundColor: Colors.blue[200], )
                : Container(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:widget.isClass ? classStream : schoolStream,
                   
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  List<DocumentSnapshot> docs = snapshot.data.documents;


                  List<Widget> messages = docs.map((doc) => Message(
                     imageUrl: doc.data()['picUrl'],
                            from: doc.data()['from'],
                            text: doc.data()['text'],
                            me: widget.userid == doc.data()['from'],
                            
                          )).toList();
                     

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                      imageFile == null
                          ? Container()
                          : Column(
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height*0.4,
                                  width: MediaQuery.of(context).size.height*0.9,
                                  child: Image.file(imageFile)),
                               !isUploadingImage ?  FlatButton(color: Colors.blue,child: Text('Send Image'),
                                  onPressed: (){callback();},):
                                  FlatButton(color: Colors.grey,child: CircularProgressIndicator(strokeWidth: 2,),
                                  onPressed: (){},),
                            ],
                          ),
                    ],
                  );
                },
              ),
            ),
            Card(
              elevation: 1,
                          child: Container(
                color: Colors.white,
                  child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: null,
                        cursorColor: Colors.indigo[200],
                        controller: messageContrl,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: const BorderRadius.all(const Radius.circular(30.0),
        ),),
                          hintText: 'Enter Your Message',
                          icon: IconButton(icon: Icon(Icons.image,color: Colors.indigo,),
                              onPressed: () => pickImage()),
                        ),
                        style: TextStyle(fontFamily: 'Ptsans',
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  SendButton(callback: callback)
                ],
              )),
            ),
        ],
      ),
          )),
    );
  }
}