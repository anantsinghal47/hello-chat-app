import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  // whenever user signedUp we have to upload its info to firestore
  // basically we are uploading a userMap which a map of key : value pair
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e){
      print(e.toString());
    });
  }
  // for searching the users
  getUserByUsername(String username) async{
  return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username ).get();
  }
  getUserByEmail(String email) async{
    return await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email ).get();
  }

  createChatRoom(String chatRoomId ,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
}


}