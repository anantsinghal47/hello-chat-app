

import 'package:flutter/material.dart';
import 'package:hello_chat_app/helper/helperFunctions.dart';
import 'package:hello_chat_app/services/auth.dart';
import 'package:hello_chat_app/services/database.dart';
import 'package:hello_chat_app/views/signin.dart';
import 'package:hello_chat_app/widgets/widget.dart';

class SignUp extends StatefulWidget{
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp>{
  
  bool isLoading = false; // for showing loading screen while signing up
  AuthMethods authMethods =  new AuthMethods(); // instantiate AuthMethods for using firebase auth services
  DatabaseMethods databaseMethods = new DatabaseMethods();
  
  
  final formKey = GlobalKey<FormState>();// this key used in validation in Form
  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  // function for on taping signUp
  signMeUp(){
    if(formKey.currentState.validate()){

      Map<String , String> userInfoMap = {
        "name":userName.text,
        "email":email.text
      };
      HelperFunctions.saveUserEmailPreference(email.text);
      HelperFunctions.saveUsernamePreference(userName.text);
    setState(() {
      isLoading=true;
    });
    authMethods.signUpWithEmailAndPassword(email.text, password.text).then((val){
      print("{val}");
      
    });




     // uploading userInfo simultaneously
      databaseMethods.uploadUserInfo(userInfoMap);
    // this replaces the screen in which we are to route
      Navigator.pushReplacement(context, MaterialPageRoute(
        // which screen we want to go
        builder: (context) => SignIn(widget.toggle)
      ));
      print("You are in chatRoom");
    
    }
  }
  // signMeIn(){
  //   setState(() {
  //     SignIn();
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      // if isLoading is true then a loading container state is visible
      // if it is false our single child scroll view is visible
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
                // for validating that user entered a input or not
                // wrapping in a form -> The form widget acts as a container, which allows us to group and validate the multiple form fields.
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // validator return a string
                        validator : (val){// val is user entered username//
                          // returning a string is below conditions are true
                          return val.isEmpty || val.length <4 ?"Username must be 4 words long" : null;
                        },
                        controller: userName,
                        style:TextStyleColor(),
                        decoration: TextFieldInputDecoration("Username"),
                      ),
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)? null : "Enter valid email address";
                        },
                        controller: email,
                        style:TextStyleColor(),
                        decoration: TextFieldInputDecoration("email"),
                      ),
                      TextFormField(
                        //obscureText: true, // for hiding password
                        validator: (val){
                          // password must be 6+ for firebase authentication
                          return val.length> 6 ? null : "password must contain 6+ characters";
                        },
                        controller: password  ,
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
                   onTap:(){
                    signMeUp();
                   } ,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 2.8), // shadow direction: bottom right
                        )
                      ],
                      // color:Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff145C9E)

                          ]),

                    ),
                    alignment: Alignment.center,
                    child: Text("Sign Up" ,
                      style: mediumTextstyle(),
                    ),
                  ),
                ),
                SizedBox(height: 10, ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color:Colors.blueGrey,
                    borderRadius: BorderRadius.circular(30),
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
                  child: Text("Sign Up With Google",
                    style: mediumTextstyle(),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?" , style:TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),),
                      GestureDetector(
                        onTap: (){
                           print("You are in sign in screen");
                           widget.toggle();
                          // signMeIn();
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //   builder:(context) => SignIn()
                          // ));
                        },
                      child: Text(" Sign In " , style:TextStyle(
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
    );
  }
}