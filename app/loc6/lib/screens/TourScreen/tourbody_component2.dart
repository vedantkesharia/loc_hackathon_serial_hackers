import 'package:flutter/material.dart';
import 'package:loc6/sizeconfig.dart';

class Commonbutton extends StatelessWidget {
  late String text;
  late VoidCallback onpress;
  Commonbutton(this.text, this.onpress);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orange,
      ),
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: GestureDetector(
          onTap: onpress,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
