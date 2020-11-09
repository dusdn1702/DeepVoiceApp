import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isSecure;
  final TextEditingController controller;

  CustomTextField(this.title, this.placeholder, this.keyboardType, this.isSecure, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.title, style: TextStyle(color: Theme.of(context).primaryColor)),
          SizedBox(height: 8.0),
          _textField(context),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: new InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.transparent),
          borderRadius: const BorderRadius.all(
            const Radius.circular(7.5),
          ),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            const Radius.circular(7.5),
          ),
        ),
        filled: true,
        hintText: this.placeholder,
      ),
      keyboardType: this.keyboardType,
      obscureText: this.isSecure,
    );
  }
}