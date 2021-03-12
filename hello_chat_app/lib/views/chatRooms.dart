



import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/authenticate.dart';
import 'package:hello_chat_app/helper/constants.dart';
import 'package:hello_chat_app/helper/helperFunctions.dart';
import 'package:hello_chat_app/services/auth.dart';
import 'package:hello_chat_app/services/database.dart';
import 'package:hello_chat_app/views/conversations.dart';
import 'package:hello_chat_app/views/search.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream : chatRoomsStream,
      builder: (context , snapshot ){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder:(context,index){
              return ChatRoomChats(
                  snapshot.data.docs[index].data()["chatroomid"].toString().replaceAll("_", "" ).replaceAll(Constants.myName, ""),
                  snapshot.data.docs[index].data()["chatroomid"]
              );
            }) : Container();
      },
    );

  }

  @override
  void initState() {
    getUserInfo();

    super.initState();

  }
  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((val){
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {
    });
    print("${Constants.myName}");
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/applogo.png" ),
        title: Text("Hello ${Constants.myName} !" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic , ),),

         actions: [
           GestureDetector(
             onTap:(){
               authMethods.signOut();
               HelperFunctions.saveUserLoggedInSharedPreference(false);
               //Constants.myName="";
               Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) => Authenticate()
               ));
               print("you were signed out , you are in sign in screen");
             },
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 30),
                 child: Icon(Icons.exit_to_app)),
           ),
         ],
      ),
      body: chatRoomList(),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(

          backgroundColor: Colors.yellow,
          child: Icon(Icons.search),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder : (context) => SearchScreen()
            ));
          },
        ),
      ) ,

    );
  }
}
class ChatRoomChats extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomChats(this.userName , this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)  => Conversation(chatRoomId, chatRoomId)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.black12
          color: Color(0xff1FA39E9E),
          // gradient: LinearGradient(
          //     colors: [
          //       Color(0xffffe27c),
          //       const Color(0xffe6eaee)
          //
          //     ]),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24 , vertical: 10),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xff1763aa),
                borderRadius: BorderRadius.circular(100),
              ),
              child:Text("${userName.substring(0,1).toUpperCase()}",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),) ,
            ),
            SizedBox(width: 25,),
            Text(userName , style: TextStyle(
              color: Colors.black54,
              fontSize: 18
            )),
          ],
        ),
      ),
    );
  }
}
