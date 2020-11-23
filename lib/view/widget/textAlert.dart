import 'package:deepvoice/view/widget/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomTextAlert extends StatelessWidget {
  final String alertTitle;
  final String hiddenText;
  final String btnText;
  final Function(String) onTap;
  final TextEditingController inputController = TextEditingController();

  CustomTextAlert(this.alertTitle, this.hiddenText, this.btnText, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            width: MediaQuery.of(context).size.width - (28.0 * 2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => {Navigator.pop(context)},
                    padding: EdgeInsets.only(top: 10),
                  ),
                ),
                Text(this.alertTitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField("", hiddenText, TextInputType.text, false, this.inputController),
                ),
                SizedBox(height: 17.3),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(this.btnText, CustomButtonType.Default, () {
                    Navigator.of(context).pop();
                    this.onTap(this.inputController.text);
                    this.inputController.clear();
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

void textAlert(BuildContext context, String alertTitle, String hiddenText, String buttonText, Function onTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTextAlert(alertTitle, hiddenText, buttonText, onTap);
      }
  );
}