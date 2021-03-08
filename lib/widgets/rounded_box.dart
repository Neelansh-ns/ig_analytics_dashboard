import 'package:flutter/material.dart';

class RoundedBoxForNumber extends StatelessWidget {
  final String title;
  final int value;

  RoundedBoxForNumber({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.pinkAccent.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
