import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/Screens/register_page.dart';
import 'package:untitled5/constants.dart';
import 'package:untitled5/widget/custom_btn.dart';
import 'package:untitled5/widget/input.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //Build an alert dialog to display some error
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        //allows only to tap the btn to close the pop
        barrierDismissible: false,
        // builder always requires context
        builder: (context){
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                  child: Text("Close Dialog"),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              )
            ],
          );
        }
    );
  }

  //if string is null user has been registered

  //Create a new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if(e.code =='weak-password'){
        return 'The password provided is too weak.';
      }else if (e.code =='email-already-in-use'){
        return'The account already exists for that email';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to loading state
    setState(() {
      _loginFormLoading = true;

    });

    //run the create account method
    // login variables always 1 caps and other functions to have cap next to it
    String _loginFeedback = await _loginAccount();

    //if the string is not null,we got error while creating account.
    if (_loginFeedback !=null) {
      _alertDialogBuilder(_loginFeedback);

      //set the form to regular state[not loading]
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  //Default form loading state
  bool _loginFormLoading=false;

  //form input field values
  String _loginEmail ="";
  String _loginPassword ="";

  //focus node for the input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode =FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Welcome user,\nLogin to your Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email..",
                    onChanged: (value) {
                      //data stored in the firebase
                      _loginEmail = value;
                    },
                    //it helps to focus on psd after entering email id
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    //the next button shows to go the next field
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password..",
                    onChanged: (value) {
                      _loginPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      //open the dialog
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage()
                      ),
                    );
                  },
                  OutlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

