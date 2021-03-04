



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/authenticate.dart';
import 'package:hello_chat_app/helper/constants.dart';
import 'package:hello_chat_app/helper/helperFunctions.dart';
import 'package:hello_chat_app/services/auth.dart';
import 'package:hello_chat_app/views/search.dart';


class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/applogo.png" ),
        title: Text("Chat Room" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic , ),),

         actions: [
           GestureDetector(
             onTap:(){
               authMethods.signOut();
               Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context) => Authenticate()
               ));
               print("you was signed out , you are in sign in screen");
             },
             child: Container(
               padding: EdgeInsets.symmetric(horizontal: 30),
                 child: Icon(Icons.exit_to_app)),
           ),
         ],
      ),
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
