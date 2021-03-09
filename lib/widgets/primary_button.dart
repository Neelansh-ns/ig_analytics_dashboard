import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String buttonText;
  final Function onTap;

  PrimaryButton({this.buttonText,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 240,
        decoration: BoxDecoration(
            color: Color(0xffe9505f),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white,fontSize: 20),
            )),
      ),
    );
  }
}
