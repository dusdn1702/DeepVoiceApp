import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomConfirm extends StatelessWidget {
  final String message;
  final String positiveText;
  final String negativeText;
  final Function onTap;

  CustomConfirm(this.message, this.positiveText, this.negativeText, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width - (28.0 * 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30.0),
                Text(this.message, textAlign: TextAlign.center),
                SizedBox(height: 22.0),
                _buttons(context),
                SizedBox(height: 16.0),
              ],
            ),
          )
      ),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: _button(context, this.positiveText, CustomButtonType.Positive, onTap: this.onTap)),
          SizedBox(width: 25.0),
          Expanded(child: _button(context, this.negativeText, CustomButtonType.Negative)),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, String text, String type, {Function onTap}) {
    return CustomButton(text, type, () {
      Navigator.of(context).pop();
      if (onTap != null) {
        onTap();
      }
    });
  }
}

void confirm(BuildContext context, String message, String positiveText, String negativeText, Function onTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomConfirm(message, positiveText, negativeText, onTap);
      }
  );
}