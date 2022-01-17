import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled5/Screens/home_page.dart';
import 'package:untitled5/Screens/login_page.dart';
import 'package:untitled5/constants.dart';

class LandingPage extends StatelessWidget {
  Future<FirebaseApp> get _intialization async => Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialization,
      builder: (context, snapshot) {
        //if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        //Connection Initialized -firebase APp is runnning
        if (snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder identifies pages automatically can check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,streamsnapshot) {
              //if  stream snapshot has error
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${streamsnapshot.error}"),
                  ),
                );
              }
              //COnnection state active -DO the user login check inside the
              //if statement
              if(streamsnapshot.connectionState == ConnectionState.active){

                //Get the user
                User _user=streamsnapshot.data;

                //user not logged in if the user is null
                if(_user==null){
                  //user not logged in,head to loginpage
                  return LoginPage();
                }else{
                  //the user in logged in,hhead to homepage
                  return HomePage();
                }
              }
              //checking the auth state -loading
              return Scaffold(
                body: Center(
                  child: Text("Checking auth",
                  style: Constants.regularHeading,
                ),
              )
              );
            },
          );
        }

        //connecting to firebase -loading
        return Scaffold(
          body: Center(
            child: Text("Intizialation App",
            style: Constants.regularHeading,
          ),
        )
        );
      },
    );
  }
}
