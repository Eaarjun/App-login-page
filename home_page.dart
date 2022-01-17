import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/constants.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
       child: FlatButton(
         child: Text("Logout"),
         onPressed: (){
           FirebaseAuth.instance.signOut();
         },
       ),
      )
      );
  }
}
