
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/constants.dart';
import 'package:hello_chat_app/services/database.dart';
import 'package:hello_chat_app/views/conversations.dart';
import 'package:hello_chat_app/widgets/widget.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchUsername = new TextEditingController();

  QuerySnapshot searchSnapshots;
  Widget searchList(){
    return searchSnapshots != null ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshots.docs.length,
        itemBuilder: (context , index){
          return SearchTile(
            userName:searchSnapshots.docs[index].data()["name"] ,
            userEmail: searchSnapshots.docs[index].data()["email"],
          );
        }
    ): Container();
  }


  initiateSearch(){
    databaseMethods.getUserByUsername(searchUsername.text).then((val){
      print(val);
      setState(() {
        searchSnapshots=val;
      });
    });
  }



  // create chatRoom  , send user to conversation screen  , push replacement
  createChatRoomAndStartCon({String userName }){
    String chatroomId =getChatRoomId(userName ,Constants.myName);
    List<String> users = [userName ,Constants.myName];
    Map<String,dynamic> chatRoomMap ={
      "users" :users,
      "chatroomid" : chatroomId
    };
    DatabaseMethods().createChatRoom(chatroomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Conversation()
    ));

  }
  Widget SearchTile({String userName,
   String userEmail}){
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName , style:  TextStyleColor(),),
                Text(userEmail , style:  TextStyleColor(),)
              ],

            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                createChatRoomAndStartCon(userName: userName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color:  Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50),

                ),
                padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                child: Text("Message" , style: TextStyle(color: Colors.white),),
              ),
            ),

          ],
        ),
      ),
    );
  }


  @override
  //as widget is constructed this function to constructed , there calling initiateSearch as without calling it gives null value
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        //leading: Image.asset("assets/images/applogo.png"),
          title: Text("Search Users" , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500 , fontStyle: FontStyle.italic ,),),
          ),
      body: Container(
        child: Column(
          children: [
            Container(
              //color: Colors.grey,
              //color: Colors.blueGrey,
              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchUsername,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search users here ...",
                          hintStyle: TextStyle(
                            color: Colors.black54,

                          ),
                        ),
                      )),
                    GestureDetector(
                      onTap: (){
                        initiateSearch();
                      },
                    child: Container(
                      height: 40,
                        width: 40,
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/images/searchfree.png", )),
                  ),
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}


// tile containing user info

getChatRoomId(String a , String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else {
    return "$a\_$b";
  }
}
