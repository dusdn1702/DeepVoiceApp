import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String type;
  final Function onTap;

  CustomButton(this.text, this.type, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
          side: BorderSide(color: _borderColor(context)),
        ),
        child: Text(this.text),
        color: _color(context),
        textColor: _textColor(context),
        onPressed: this.onTap,
      ),
    );
  }

  Color _color(BuildContext context) {
    if (this.type == CustomButtonType.Default) {
      return Theme.of(context).buttonColor;
    }
    if (this.type == CustomButtonType.Border) {
      return Colors.white;
    }
    if (this.type == CustomButtonType.Positive) {
      return Theme.of(context).accentColor;
    }
    if (this.type == CustomButtonType.Negative) {
      return Theme.of(context).errorColor;
    }
    return Colors.white;
  }

  Color _textColor(BuildContext context) {
    if (this.type == CustomButtonType.Border) {
      return Theme.of(context).buttonColor;
    }
    return Colors.white;
  }

  Color _borderColor(BuildContext context) {
    if (this.type == CustomButtonType.Border) {
      return Theme.of(context).buttonColor;
    }
    return Colors.transparent;
  }
}

class CustomButtonType {
  static const Default = "DEFAULT";
  static const Border = "BORDER";
  static const Positive = "POSITIVE";
  static const Negative = "NEGATIVE";
}