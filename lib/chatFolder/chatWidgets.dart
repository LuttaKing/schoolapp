
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/chatFolder/picscreen.dart';


class Message extends StatefulWidget {
  final String from;
  final String text;
  final bool me;
  final imageUrl;

  Message({this.from, this.text, this.me, this.imageUrl});
   @override
  _MessageState createState() => _MessageState();

}

class _MessageState extends State<Message> {

 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                widget.me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                widget.from,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.me ? Colors.white : Colors.green[200],
                ),
              ),
              Material(
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.me ? Colors.orange : Colors.indigo[200],
                    borderRadius: widget.me
                        ? BorderRadius.only(
                            topLeft: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                            bottomLeft: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                            bottomRight: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                          )
                        : BorderRadius.only(
                            topRight: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                            bottomLeft: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                            bottomRight: !widget.text.contains('firebasestorage')
                                ? Radius.circular(50.0)
                                : Radius.circular(15),
                          ),
                  ),
                  padding: !widget.text.contains('firebasestorage')
                      ? EdgeInsets.symmetric(vertical: 10, horizontal: 15)
                      : EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: widget.text.contains('firebasestorage')
                      //https://stackoverflow.com/questions/53577962/better-way-to-load-images-from-network-flutter
                      ? Container(
                          height: 200,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: GestureDetector(
                            child: Hero(tag:widget.text,
                                                          child: CachedNetworkImage(
                                  
                                  imageUrl: widget.text,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Container(
                                          height: 70,
                                          width: 70,
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                              onTap:(){
                              FocusScope.of(context).unfocus();
                            Navigator.push(
                            context,
                             MaterialPageRoute(
                             builder: (context) => PicScreen(imageurl: widget.text,herotag: widget.text,),
                             ));
                            },
                            ),
                          ),
                        )
                      : Text(widget.text,
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Ptsans')),
                ),
              )
            ]),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final VoidCallback callback;
  SendButton({this.callback});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.indigo[400],
      onPressed: callback,
      icon: Icon(Icons.send),
    );
  }
}
