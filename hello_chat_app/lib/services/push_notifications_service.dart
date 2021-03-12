import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotifications{
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future intialise() async {
    _fcm.configure(

      //Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async{
        print("onMessage : $message");
      },
       //called when the app has been closed completely and its opened
       //from the push notification directly

       onLaunch: (Map<String, dynamic> message) async{
      print("onMessage : $message");
    },
      //called when app is the background and its opened
        // from the push notifications
     onResume: (Map<String, dynamic> message) async{
      print("onMessage : $message");
    }



    );

  }
}