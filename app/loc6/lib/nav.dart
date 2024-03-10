import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loc6/screens/HomeScreen/home_screen.dart';
import 'package:loc6/screens/ObjectRecognition/camera.dart';
import 'package:loc6/screens/ObjectRecognition/object_recognition.dart';
import 'package:loc6/screens/ocr.dart';
import 'package:loc6/screens/outdoor.dart';
import 'package:loc6/screens/speech_to_text.dart';
import 'package:loc6/screens/web_view.dart';
import 'package:loc6/sizeconfig.dart';


class Bottom_Nav extends StatefulWidget {
  const Bottom_Nav({Key? key}) : super(key: key);

  @override
  State<Bottom_Nav> createState() => _Bottom_NavState();
}

class _Bottom_NavState extends State<Bottom_Nav> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    ObjectLens(),
    OcrLens(),
    Outdoor(),
    SignWebView(),
    SpeechText(),
  ];

  void _onitemtapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getproportionatescreenwidth(20),
          vertical: getproportionatescreenheight(10),
        ),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.black,
        ),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          gap: 3,
          tabBackgroundColor: Colors.grey.shade900,
          padding: EdgeInsets.all(12),
          selectedIndex: _selectedIndex,
          onTabChange: _onitemtapped,
          tabs: [
            GButton(
              icon: Icons.home_outlined,
              text: "Home",
            ),
            GButton(
              icon: Icons.remove_red_eye_rounded,
              text: "Look around",
            ),
            GButton(
              icon: Icons.text_fields,
              text: "Detect text",
            ),
            GButton(
              icon: Icons.location_on,
              text: "Locate",
            ),
            GButton(
              icon: Icons.sign_language,
              text: "Sign",
            ),
            GButton(
              icon: Icons.keyboard_voice_rounded,
              text: "Audio to text",
            ),
          ],
        ),
      ),
    );
  }
}


