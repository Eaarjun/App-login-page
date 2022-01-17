import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  CustomInput({this.hintText,this.onChanged,this.onSubmitted,this.focusNode,this.textInputAction,this.isPasswordField});

    @override
    Widget build(BuildContext context) {
      bool _isPassswordField=isPasswordField ?? false;


      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 24.0,
        ),
        decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12.0),
            ),
          child: TextField(
            obscureText: _isPassswordField,
            focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      decoration: InputDecoration(
      border: InputBorder.none,
          hintText: hintText ?? "HInt Text...",
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical:18.0,
          )
      ),
      style: Constants.RegularDarkText,
      ),
      );
    }
  }
