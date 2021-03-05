
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_chat_app/services/auth.dart';
import 'package:hello_chat_app/services/database.dart';
import 'package:hello_chat_app/views/SigninIncorrect.dart';
import 'package:hello_chat_app/views/chatRooms.dart';
import 'package:hello_chat_app/helper/helperFunctions.dart';
import 'package:hello_chat_app/widgets/widget.dart';

class SignIn extends StatefulWidget{
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn>{
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  bool isIncorrect = false;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  QuerySnapshot snapshotUserInfo;

  signMeIn(){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailPreference(email.text);
      //HelperFunctions.saveUsernamePreference(password.text);

      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByEmail(email.text).then((val){
        snapshotUserInfo=val;
        HelperFunctions.saveUsernamePreference(snapshotUserInfo.docs[0].data()["name"]);
        print("${snapshotUserInfo.docs[0].data()["name"]}");
        }
      );
      authMethods.signInWithEmailAndPassword(email.text, password.text).then((val){
        print("$val");
        if(val != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            // which screen we want to go
              builder: (context) => ChatRoom()));
        }
        else{
          isIncorrect =true;
          Navigator.pushReplacement(context, MaterialPageRoute(
            // which screen we want to go
              builder: (context) => SignInc(widget.toggle)
          ));
        }
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/applogo.png" ,
          height: 50 ,
        ),
         actions: [
           Container(
             padding:EdgeInsets.symmetric(horizontal: 20) ,
               child: IconButton(
                 icon: Icon( Icons.search ),
                onPressed: (){},
               ),

           )
         ],
      ), // creating appbar function which in return gives us a widget
      body: isLoading ? Container(
        // for loading as circular
          child : Center(child: CircularProgressIndicator())
      ) :SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-150  ,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min ,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (val){
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null : "Enter valid email address";
                           },
                          controller: email,
                          style:TextStyleColor(),
                          decoration: TextFieldInputDecoration("email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          // password must be 6+ for firebase authentication
                          return val.length> 6 ? null : "enter valid password";
                        },
                        controller: password,
                        style: TextStyleColor(),
                        decoration:TextFieldInputDecoration("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                    child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      child: Text("Forgot Password ?",
                        style: TextStyleColor(),
                      ),
                    )
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                    signMeIn();
                  },
                  child: Container(

                   // height: 65,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                       // color:Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            colors: [
                            const Color(0xff007EF4),
                            const Color(0xff145C9E)

                             ]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 2.8), // shadow direction: bottom right
                        )
                      ],
                            ),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: (){
                          signMeIn();
                        },
                        child: TextButton(
                          onPressed: () async {},
                          child: GestureDetector(

                            onTap: (){
                              //widget.toggle();
                              signMeIn();
                            },
                            child: Text("Sign In" ,
                                  style: mediumTextstyle(),
                                ),
                          ),
                        ),
                      ),
                        ),
                ),
                      SizedBox(height: 10, ),
                //SignUpWithGoogle Button
                Container(
                 // height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    color:Colors.blueGrey,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 2.8), // shadow direction: bottom right
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {},
                    child: Text("Sign in With Google",
                      style: mediumTextstyle(),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                //registerNow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?" , style:TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();// switching the signIn screen to SignUp screen

                        },
                        child: Text("Register now" , style:TextStyle(
                        color: Colors.indigo,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),),
                    ),
                    SizedBox(height: 150,)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: TextButton(
      //   onPressed: null,
      // ),

    );
  }
}

