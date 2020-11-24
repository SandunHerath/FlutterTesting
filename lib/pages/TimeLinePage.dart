import 'package:flutter/material.dart';
import 'package:instaApp/widgets/HeaderWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instaApp/widgets/ProgressWidget.dart';

GoogleSignIn gSignIn =GoogleSignIn();

class TimeLinePage extends StatefulWidget {

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context,isAppTitle:true,),
      //body:
    );
  }
}

logoutUser(){
  gSignIn.signOut();
}
