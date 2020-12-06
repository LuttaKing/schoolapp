import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolapp/COMMON/common.dart';

class AddSellItem extends StatefulWidget {
  @override
  _AddSellItemState createState() => _AddSellItemState();
}

class _AddSellItemState extends State<AddSellItem> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  File imageFile;
  bool isUploadingImage = false;
  String imageUrl;
  final FirebaseStorage _storage =FirebaseStorage(storageBucket: 'gs://schoolapp-756e6.appspot.com');
  StorageUploadTask _uploadTask;
  bool isLoading=false;
   var someStream;
   @override
  void initState() {
    super.initState();
   
     someStream= firestore.collection('principal').snapshots();
  }
  final _formKey = GlobalKey<FormState>();

  String price='';
  String name='';
  String number='';

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
       leading: IconButton(icon: Icon(Icons.close,color: Colors.black,),onPressed: (){Navigator.pop(context);},),
      title: Text('Add Item',style: TextStyle(fontFamily: 'Ptsans',color: Colors.black),),
      centerTitle: true,elevation: 0, ),
        bottomNavigationBar: BottomAppBar(
    color: Colors.white,
  
    child: _bottomButton(),
    elevation: 0,
  ),
      body: Container(color: Colors.grey[100],
       
            child: Center(
      child: ListView(
        children: <Widget>[
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
      Text('Fill in the Form',style: TextStyle(fontSize: 26,fontFamily: 'Nunito',letterSpacing: 1),),
 SizedBox(height: MediaQuery.of(context).size.height*0.027,),
 Padding(
       padding: const EdgeInsets.all(12.0),
       child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),),
                    child: TextFormField(
                      
                       validator: (val)=> val.length!=10 || !val.contains('0') ? 'Enter Valid Number' : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.call),
                      labelText: ' Phone Number',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                    onChanged: (val){
                      setState(()=> number=val);
                    },
                    ),
                  ),
                  SizedBox(   height:MediaQuery.of(context).size.height*0.03,),
                
                  Container(decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),),
                    child: TextFormField(
                      
                      validator: (val)=> val.length<5 ? 'Item name Should Be Longer' : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.near_me_rounded),
                          labelText: ' Item name',
                          labelStyle: TextStyle(fontSize: 14)),
                          onChanged: (val){
                      setState(()=> name=val);
                    },
                    ),
                  ),
                             SizedBox(   height:MediaQuery.of(context).size.height*0.03,),
                
                  Container(decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),),
                    child: TextFormField(
                      
                      validator: (val)=> val.length<2 ? 'Please add a price' : null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.monetization_on),
                          labelText: ' Price',
                          labelStyle: TextStyle(fontSize: 14)),
                          onChanged: (val){
                      setState(()=> price=val);
                    },
                    ),
                  ),
                ]),
              ),
             ),
imageFile == null
                          ? Container()
                          : Column(
                            children: [
                              Container(
                                  height: MediaQuery.of(context).size.height*0.36,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Image.file(imageFile)),
                             
                            ],
                          ),
Padding(
  padding: const EdgeInsets.only(left:38.0,right: 38),
  child:   FlatButton(color: Colors.orange,child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
          Icon(Icons.image),
          Text('Pick Image')
    ],
  ),onPressed: (){
    pickImage();
  },),
)
   
          ],),
            ),
          ),
    );
  }
    Widget _bottomButton(){
    return Padding(
      padding:  EdgeInsets.all(18.0),
      child: SizedBox(
                  height:MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width*0.6,
                child: FlatButton(
                  color: Colors.blue,child:isLoading?CircularProgressIndicator(strokeWidth: 2,): Text('Post',
                  style: TextStyle(color: Colors.white,fontFamily: 'New',letterSpacing: 2),),
                  onPressed: (){
 if(_formKey.currentState.validate()){
  setState(() {
     isLoading=true;
   });
   if(imageFile!=null){
callback().then((val){
   setState(() {
     isLoading=false;
   });
   tost('Refresh to see');
Navigator.pop(context);
});
   }else{
tost('Please pick a file');
   }
                          }
               
                },),),
    );
  }
  Future pickImage() async {
    File selectedimage =await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
     
      imageFile = selectedimage;
    });
  }
  Future<void> callback() async {

      await _startUpload().then((picUrl) async {
//after upload post link
   
        await firestore.collection('shop').add({
          'name': name,
          'number': number,
          'price': price,
          'image':imageUrl
        });
      
       
      });
    
  }
   Future _startUpload() async {
    isUploadingImage = true;
   
      String filePath = 'shop images/${DateTime.now()}.png';
      //upload image
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(imageFile);
    });
   
    
    // get Url
    StorageTaskSnapshot taskSnapshot = await _uploadTask.onComplete;
    String picUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      imageUrl=picUrl;
    });

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
}