import 'package:flutter/material.dart';
import 'tourscreen_body1.dart';
import 'package:loc6/sizeconfig.dart';

class Tourscreen extends StatelessWidget {
  const Tourscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sizeconfiguration().access(context);
    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Body(),
      ),
    );
  }
}
