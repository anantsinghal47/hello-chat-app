import 'dart:ui';

import 'package:flutter/material.dart';
Widget appBarMain(BuildContext context){
  return AppBar(

    title: Image.asset("assets/images/applogo.png" ,
      height: 50 ,
     ),
    // actions: [
    // ],
  );
}
// ignore: non_constant_identifier_names
InputDecoration TextFieldInputDecoration( String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black54,
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black54)
    ),
  );
}

// ignore: non_constant_identifier_names
TextStyle TextStyleColor(){
  return TextStyle(
    color: Colors.blueGrey,
    fontSize: 15
  );
}
TextStyle mediumTextstyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}