import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomAlert extends StatelessWidget {
  final String message;
  final String btnText;
  final Function onTap;

  CustomAlert(this.message, this.btnText, {this.onTap});

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
              Container(
                width: double.infinity,
                child: CustomButton(this.btnText, CustomButtonType.Default, () {
                  Navigator.of(context).pop();
                  if (this.onTap != null) {
                    this.onTap();
                  }
                }),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        )
      ),
    );
  }
}

void alert(BuildContext context, String message, String buttonText, {Function onTap}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlert(message, buttonText, onTap: onTap);
    }
  );
}