import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deepvoice/view/widget/button.dart';

class CustomTwoButtonAlert extends StatelessWidget {
  final String alertTitle;
  final Function onTap;

  CustomTwoButtonAlert(this.alertTitle, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FittedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                const Radius.circular(7.5),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(alertTitle, textAlign: TextAlign.center),
                SizedBox(height: 21.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 130,
                        child: CustomButton(
                            "확인", CustomButtonType.Positive, () {
                          Navigator.of(context).pop();
                          //여기서 친구 요청 취소 함수
                        }),
                      ),
                      SizedBox(width: 29.5),
                      Container(
                        width: 130,
                        child: CustomButton(
                            "닫기", CustomButtonType.Negative, () {
                          Navigator.of(context).pop();
                        }),
                      ),
                    ]),
                SizedBox(height: 16),
              ],
            ),
          )
      ),
    );
  }
}

void twoButtonAlert(BuildContext context, String alertTitle, {Function onTap}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTwoButtonAlert(alertTitle, onTap: onTap);
      }
  );
}