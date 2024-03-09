import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../main.dart';

//late List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      //setState(() {});
      controller.startImageStream((CameraImage image) {
        // You can process the image frame here
        print('here');
        final gemini = Gemini.instance;
        //final file = File('assets/images/1.png');

        gemini.textAndImage(
            text: "What is this picture?", /// text
            images: image.planes.map((plane) => plane.bytes).toList(), /// list of images
            //images: [file.readAsBytesSync()],
            modelName: 'gemini-pro-vision'
        )
            .then((value) => print(value?.content?.parts?.last.text ?? ''))
            .catchError((e) => print('textAndImageInput'+e.toString()));
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
      Text('hello')
    ]);
  }
}
