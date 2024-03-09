import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:loc6/nav.dart';
import 'tourbody_component.dart';
import 'tourbody_component2.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  late Animation<Offset> _listoffset;
  late Animation<double> _opacity;
  int currpos = 0;
  final PageController controller = PageController();
  FlutterTts flutterTts = FlutterTts();

  List<Map<String, String>> data = [
    {
      "imgno": "1",
      "text": "Help navigate your\n life!",
    },
    {
      "imgno": "2",
      "text": "Take charge of your\n surroundings!",
    },
    {
      "imgno": "3",
      "text": "Communicate and move effectively!",
    }
  ];

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.forward();
    _offset = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _listoffset = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      flutterTts.speak("welcome to Your Sense, press anywhere to continue");
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Bottom_Nav()),
        );
      },
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SlideTransition(
                position: _listoffset,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(
                      () {
                        currpos = value;
                      },
                    );
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      touchscreenbody(data[index]["imgno"], data[index]["text"]),
                  physics: BouncingScrollPhysics(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      data.length,
                      (index) => buildContainer(index),
                    ),
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  FadeTransition(
                    opacity: _opacity,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          "Your Sense",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 30
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _offset,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          "Navigate and Communicate",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _opacity,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Commonbutton(
                          "Start",
                          () {
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildContainer(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.all(5),
      height: 10,
      width: currpos == index ? 30 : 10,
      decoration: BoxDecoration(
        color: currpos == index ? Colors.orange : Colors.grey.shade700,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
