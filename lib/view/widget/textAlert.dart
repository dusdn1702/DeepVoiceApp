import 'package:deepvoice/view/widget/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomTextAlert extends StatelessWidget {
  final String alertTitle;
  final String hiddenText;
  final String btnText;
  final TextEditingController inputController;
  final Function onTap;

  CustomTextAlert(this.alertTitle, this.hiddenText, this.btnText, this.inputController, {this.onTap});

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
                IconButton(
                  icon: const Icon(Icons.close, size: 10),
                  onPressed: () => {Navigator.pop(context)},
                  padding: EdgeInsets.only(left: 197, top: 19, right: 15, bottom: 8),
                ),
                Text(this.alertTitle, textAlign: TextAlign.center),
                SizedBox(height: 16.5),
                Container(
                  width: double.infinity,
                  child: CustomTextField("", hiddenText, TextInputType.text, false, this.inputController),
                ),
                SizedBox(height: 17.3),
                Container(
                  child: CustomButton(this.btnText, CustomButtonType.Default, () {
                    Navigator.of(context).pop();
                    if (this.onTap != null) {
                      this.onTap();
                    }
                  }),
                ),
                SizedBox(height: 19.5),
              ],
            ),
          )
      ),
    );
  }
}

void textAlert(BuildContext context, String alertTitle, String hiddenText, String buttonText, TextEditingController inputController, {Function onTap}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTextAlert(alertTitle, hiddenText, buttonText, inputController, onTap: onTap);
      }
  );
}