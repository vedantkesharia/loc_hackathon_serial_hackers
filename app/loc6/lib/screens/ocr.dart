import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class OcrLens extends StatefulWidget {
  @override
  State<OcrLens> createState() => _OcrLensState();
}

class _OcrLensState extends State<OcrLens> {
  FlutterTts flutterTts = FlutterTts();
  ui.Image? _image;
  final ImagePicker _picker = ImagePicker();
  List<DetectedObject> _detectedObjects = [];
  String _final_text = "";
  final ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler(
    ImageLabelerOptions(confidenceThreshold: 0.8),
  );

  List labelName = [];
  List confidence = [];
  List price = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("en-US");
    flutterTts.setPitch(1.0);
    try {
      flutterTts.speak("Tap to open Gallery. Double tap to open camera");
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  Future<void> _getImage() async {
    labelName.clear();
    confidence.clear();
    price.clear();
    setState(() {
      total = 0;
    });
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final imageBytes = File(pickedFile.path).readAsBytesSync();
        final image = await decodeImageFromList(imageBytes);
        final String path = pickedFile.path;
        setState(() {
          _image = image;
          _detectedObjects = [];
          _final_text = "";
        });
        _detectObjects(image, path);
      }
    } on Exception catch (e) {
      // TODO
      print('image pick'+e.toString());
    }
  }

  Future<void> _getImageGallery() async {
    labelName.clear();
    confidence.clear();
    price.clear();
    setState(() {
      total = 0;
    });
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = File(pickedFile.path).readAsBytesSync();
        final image = await decodeImageFromList(imageBytes);
        final String path = pickedFile.path;
        setState(() {
          _image = image;
          _detectedObjects = [];
          _final_text = "";
        });
        _detectObjects(image, path);
      }
    } on Exception catch (e) {
      // TODO
      print('image pick'+e.toString());
    }
  }


  Future<void> _detectObjects(ui.Image image, String path) async {
    final ObjectDetectorOptions options = ObjectDetectorOptions(
      mode: DetectionMode.single,
      classifyObjects: true,
      multipleObjects: true,
    );

    int next(int min, int max) {
      final _random = new Random();
      return min + _random.nextInt(max - min);
    }

    final _objectDetector =
    GoogleMlKit.vision.objectDetector(options: options);
    final _textDetector =
    GoogleMlKit.vision.textRecognizer();

    final inputImage = InputImage.fromFilePath(path);
    final imageLabels = await imageLabeler.processImage(inputImage);
    // final objectLabels = await _objectDetector.processImage(inputImage);
    final recognized_text = await _textDetector.processImage(inputImage);
    String objectsstr = "";
    for (final label in imageLabels) {
      print('Label: ${label.label}, Confidence: ${label.confidence}');
      objectsstr += ","+ label.label;
      labelName.add(label.label);
      confidence.add(label.confidence);
      price.add(next(500, 1500));
    }

    try {
      flutterTts.speak("Text is: "+recognized_text.text);
      print("Text is: "+recognized_text.text);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }

    for (final int p in price) {
      total = total + p;
    }

    final objects = await _objectDetector.processImage(inputImage);

    setState(() {
      _detectedObjects = objects;
      _final_text = recognized_text.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Text Recogniser",
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _image == null
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150.0, left: 50),
                  child: Image.asset('assets/images/empty_text.png'),
                ),
                InkWell(
                  highlightColor: Colors.orange,
                  onTap: _getImageGallery,
                  child: Text(
                    "Open Gallery",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  //onTap: _getImage,
                    child: Icon(Icons.camera_alt_rounded)
                ),
              ],
            )
                : FittedBox(
              fit: BoxFit.contain,
              child: CustomPaint(
                size: Size.fromWidth(
                  _image!.width.toDouble(),
                ),
                painter: ObjectPainter(_image!, _detectedObjects),
                child: Container(
                  width: _image!.width.toDouble(),
                  height: _image!.height.toDouble(),
                ),
              ),
            ),
            _image != null
                ? ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: labelName.length,
                //     itemBuilder: (context, index) {
                //       return Column(
                //         children: [
                //           ListTile(
                //             title: Text(
                //               labelName[index],
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //             subtitle: Text(
                //               "Confidence: ${confidence[index]}",
                //               style: TextStyle(
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ),
                //           Divider(
                //             color: Colors.grey,
                //           )
                //         ],
                //       );
                //     }),
                SizedBox(height: 30,),
                Center(child:Text(_final_text)),
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: InkWell(
                    onTap: _getImageGallery,
                    child: Text(
                      "Choose your image",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            )
                : Container(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(

      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class ObjectPainter extends CustomPainter {
  final ui.Image image;
  final List<DetectedObject> objects;

  ObjectPainter(this.image, this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..color = Colors.green;

    canvas.drawImage(image, Offset.zero, paint);

    for (var object in objects) {
      canvas.drawRect(
        object.boundingBox,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ObjectPainter oldDelegate) {
    return true;
  }
}
