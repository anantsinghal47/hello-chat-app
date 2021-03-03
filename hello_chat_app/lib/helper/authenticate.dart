import 'package:flutter/material.dart';
import 'package:hello_chat_app/views/signin.dart';
import 'package:hello_chat_app/views/signup.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}
// for switching screens , in navigation it creates stacks of screen
class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
    return SignIn(toggleView);
    }
    else{
    return SignUp(toggleView);
    }
  }
}
