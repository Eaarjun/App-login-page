

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/widget/custom_btn.dart';
import 'package:untitled5/widget/input.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if(e.code =='weak-password'){
        return 'The password provided is too weak.';
      }else if (e.code =='email-already-in-use'){
       return 'The account already exxists for that email';
      }
      return e.message;
    } catch (e) {
    return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to loading state
    setState(() {
      _registerFormLoading = true;

    });

    //run the create account method
    String _createAccountFeedback = await _createAccount();

   //if the string is not null,we got error while creating account.
    if (_createAccountFeedback !=null) {
       _alertDialogBuilder(_createAccountFeedback);

       //set the form to regular state[not loading]
    setState(() {
      _registerFormLoading = false;
    });
    }else{
      //the string was null user is logged in
      Navigator.pop(context);
    }
  }

  //Default form loading state
  bool _registerFormLoading=false;

  //form input field values
  String _registerEmail ="";
  String _registerPassword ="";

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
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email..",
                    onChanged: (value){
                      _registerEmail=value;
                    },
                    //it helps to focus on psd after entering email id
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    //the next button shows to go the next field
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password..",
                    onChanged: (value){
                      _registerPassword=value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField:true,
                    onSubmitted: (value){
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: (){
                      //open the dialog
                    _submitForm();
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: (){
                    // head back to login
                    Navigator.pop(context);
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
