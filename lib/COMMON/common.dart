import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schoolapp/VideoCall/CallPage.dart';
import 'package:url_launcher/url_launcher.dart';

void tost(String message,[Color color]){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor:color==null ? Colors.green :Colors.red,
        textColor: Colors.white,
        fontSize: 17.0
    );
  }


    Widget entatainItem(String name){

    return GestureDetector(
          child: Column(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(13),
          child: Container(child: Icon(Icons.local_cafe,size: 17,color: Colors.white,),height: 55,width: 55,color:name=='Facebook'?Colors.blue:name=='TikTok'?Colors.black:
          name=='Instagram'?Colors.pink:name=='Whatsapp'?Colors.green
          :name=='Pinterest'?Colors.red[200]:
          name=='Music'?Colors.orange:name=='Youtube'?Colors.red[700]
          :name=='Twitter'?Colors.lightBlue:name=='Memes'?Colors.brown: Colors.yellow,)),
          SizedBox(height: 5,),
          Text(name),
        ],
      ),
      onTap: () async{
        if (name=='Whatsapp') {
           bool isInstalled = await DeviceApps.isAppInstalled('com.whatsapp');
          if(isInstalled){
                               DeviceApps.openApp('com.whatsapp');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }

        } else if(name=='Twitter'){
           bool isInstalled = await DeviceApps.isAppInstalled('com.twitter.android');
          if(isInstalled){
                               DeviceApps.openApp('com.twitter.android');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }
        }
        else if(name=='Pinterest'){
          bool isInstalled = await DeviceApps.isAppInstalled('com.pinterest');
          if(isInstalled){
                               DeviceApps.openApp('com.pinterest');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }

        }
        else if(name=='Youtube'){
            bool isInstalled = await DeviceApps.isAppInstalled('com.google.android.youtube');
          if(isInstalled){
                               DeviceApps.openApp('com.google.android.youtube');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }
        }
        else if(name=='Instagram'){
             bool isInstalled = await DeviceApps.isAppInstalled('com.instagram.android');
          if(isInstalled){
                               DeviceApps.openApp('com.instagram.android');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }
        }
        else if(name=='Facebook'){
                 bool isInstalled = await DeviceApps.isAppInstalled('com.facebook.katana');
          if(isInstalled){
                               DeviceApps.openApp('com.facebook.katana');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }
        }
        else if(name=='TikTok'){
               bool isInstalled = await DeviceApps.isAppInstalled('com.zhiliaoapp.musically');
          if(isInstalled){
                               DeviceApps.openApp('com.zhiliaoapp.musically');

          }else{
 tost('Please Intsall $name first');
        DeviceApps.openApp('com.android.vending');
          }
        }
        else if(name=='Music'){
         
           const url = 'https://tubidy.mobi/';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            tost('Error occured');
          }
        }
         else if(name=='Quotes'){
          
           const url = 'https://www.goodreads.com/quotes';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            tost('Error occured');
          }
        }
         else if(name=='Memes'){
          
           const url = 'https://memes.com/';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            tost('Error occured');
          }
        }
       
      },
    );

  }
Widget joinMeeting(BuildContext context,){
return GestureDetector(
  child:   Container(color: Colors.green,
          height:MediaQuery.of(context).size.height*0.045,width: MediaQuery.of(context).size.width,
          child: Center(child: Text('Join a video meeting',
          style: TextStyle(color: Colors.white),)),),
          onTap: (){
goToCallPage(context,'principal');
          },
);
}

 Future<void> requestCameraAndMic() async {
  await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  goToCallPage(BuildContext context,String channelName)async{
  await requestCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: channelName,
            role: ClientRole.Audience,
          ),
        ),
      );
  }