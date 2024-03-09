import 'package:flutter/material.dart';
import 'package:loc6/sizeconfig.dart';

class touchscreenbody extends StatelessWidget {
  touchscreenbody(this.imgno, this.text);
  final String? imgno;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            "assets/images/$imgno.png",
            height: getproportionatescreenheight(350),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "$text",
            style: TextStyle(color: Colors.black, fontSize: 20),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
