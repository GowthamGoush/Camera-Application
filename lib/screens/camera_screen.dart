import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mowito_camera_application/components/paint_random_points.dart';
import 'package:mowito_camera_application/screens/camera_preview_page.dart';
import 'package:mowito_camera_application/screens/image_screen.dart';
import 'package:screenshot/screenshot.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  GlobalKey<CameraAppState> key = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();
  List<bool> isSelected = [false, false];
  late ValueChanged<List<Point>> onChange;
  late List<Point> _points;

  @override
  void initState() {
    super.initState();

    onChange = (value) {
      _points = value;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Stack(
          alignment: FractionalOffset.center,
          children: [
            Positioned.fill(
              child: CameraPreviewPage(
                key: key,
              ),
            ),
            Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: RandomPoints(onChange),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.80),
                fillColor: Colors.white.withOpacity(0.80),
                splashColor: Colors.white.withOpacity(0.80),
                borderRadius: BorderRadius.circular(4.0),
                borderWidth: 2.0,
                isSelected: isSelected,
                constraints: BoxConstraints.tightForFinite(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.06),
                onPressed: (index) async {
                  switch (index) {
                    case 0:
                      setState(() {});
                      break;
                    case 1:
                      final imagePath = await key.currentState?.saveImage();
                      if (imagePath == null) break;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageScreen(
                              imagePath: imagePath,
                              generatedPointsList: _points)));
                      break;
                  }
                },
                children: const [
                  Icon(Icons.shuffle),
                  Icon(Icons.camera),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
