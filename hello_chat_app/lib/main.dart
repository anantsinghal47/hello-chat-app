import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/authenticate.dart';
import 'package:hello_chat_app/helper/helperFunctions.dart';
import 'package:hello_chat_app/views/chatRooms.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
    setState(() {
      userIsLoggedIn = val;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //Color(0xff145C9E)
          primaryColor: Color(0xff145C9E),
          scaffoldBackgroundColor: CupertinoColors.white,
          primarySwatch: Colors.lightBlue,
        ),
        home:  userIsLoggedIn ? ChatRoom() : Authenticate()

      );

  }
}
class IamBlank extends StatefulWidget {
  @override
  _IamBlankState createState() => _IamBlankState();
}

class _IamBlankState extends State<IamBlank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
