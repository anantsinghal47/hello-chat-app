import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/constants.dart';
import 'package:hello_chat_app/services/database.dart';
import 'package:hello_chat_app/widgets/widget.dart';

class Conversation extends StatefulWidget {
  final String chatRoomId;
  final String searchedUsername;
  Conversation(this.chatRoomId ,this.searchedUsername);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  TextEditingController message = new  TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatMessagesStream;

  Widget chatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          //shrinkWrap: true,
           itemCount: snapshot.data.docs.length,
            itemBuilder: (context , index){
             return  MessageTile(
                 snapshot.data.docs[index].data()["message"],
                 snapshot.data.docs[index].data()["sendBy"] == Constants.myName
             );
            }) : Center(child: CircularProgressIndicator());
      },
    );
  }
  sendMessages() {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": message.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().toIso8601String().toString()
      };

      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    }
  }
  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }
 // ${widget.chatRoomId}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/applogo.png" ,),
         title: Text(widget.searchedUsername.toString().replaceAll("_", "").replaceAll(Constants.myName, "") , style: TextStyle(fontSize: 18),),
        actions: [
          GestureDetector(
            onTap:(){

            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Icon(Icons.arrow_drop_down_sharp)),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 65,
               // margin: EdgeInsets.only(bottom: 10 , right: 5 , left: 5),
               //  decoration: BoxDecoration(gradient: LinearGradient(
               //      colors: [
               //        const Color(0xff4e8dd0),
               //        Color(0xff417cb4)
               //      ]),
                 // borderRadius: BorderRadius.circular(100),
                  //color: Colors.grey

                color: Color(0xff145C9E),
                //color: Colors.grey,
                //color: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20 , ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // gradient: LinearGradient(
                            //   colors: [
                            //     const Color(0xff4e8dd0),
                            //     Color(0xff427cbd)
                            //   ]),
                            //color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            //border: Border.all(color: Colors.blueGrey ),
                          ),
                          child: TextField(
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black ,
                              //fontStyle: FontStyle.italic ,
                            ),
                            //cursorColor: Colors.white54,
                            controller: message,
                            decoration: InputDecoration(
                              // focusColor: Colors.white54,
                              // fillColor: Colors.white54,
                              // hoverColor: Colors.white54,
                              border: InputBorder.none,
                              hintText: "type here ...",
                              hintStyle: TextStyle(
                                color: Colors.black54,

                              ),
                            ),
                          ),
                        )),
                    GestureDetector(
                      onTap: (){
                        sendMessages();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(5),
                          child: Container(
                              padding : EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xff78b5ef),
                                      Color(0xfffff474)
                                    ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset("assets/images/send3.png", ))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;

  MessageTile(this.message , this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 5 , right: isSendByMe ? 5 :0 ),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5 ,vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: isSendByMe ? BorderRadius.only( bottomLeft:Radius.circular(20) , topLeft:Radius.circular(20) ,topRight: Radius.circular(10)  ) :
          BorderRadius.only( topRight:Radius.circular(20) , topLeft: Radius.circular(10) , bottomRight: Radius.circular(20)) ,
          gradient: LinearGradient(
              colors: isSendByMe ? [
                const Color(0xff2a72bf),
                       Color(0xff19548d)
              ] : [
                const Color(0xff59677b),
                const Color(0xff465c80)
              ])
          // color: isSendByMe ? Color(0xff145C9E): Colors.blueGrey
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          child: Text(message , style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: isSendByMe ? Colors.white : Colors.white
          ),),
        ),
      ),
    );
  }
}
