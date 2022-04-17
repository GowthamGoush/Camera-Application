import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mowito_camera_application/components/paint_random_points.dart';
import 'package:mowito_camera_application/screens/camera_preview_page.dart';
import 'package:mowito_camera_application/screens/image_screen.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  GlobalKey<CameraAppState> key = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();
  List<bool> isSelected = [false,false];
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
              child: CameraPreviewPage(key: key,),
            ),
            Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: RandomPoints(onChange),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.80),
                fillColor: Colors.white.withOpacity(0.80),
                splashColor: Colors.white.withOpacity(0.80),
                borderRadius: BorderRadius.circular(4.0),
                borderWidth: 2.0,
                isSelected: isSelected,
                onPressed: (index) async {
                  // Respond to button selection
                  // setState(() {
                  //   isSelected[index] = !isSelected[index];
                  // });

                  switch(index) {
                    case 0:
                      setState(() {
                      });
                      break;
                    case 1:
                      final imagePath = await key.currentState?.saveImage();
                      if(imagePath == null) break;
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageScreen(imagePath: imagePath, generatedPointsList: _points)));
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

  Future<String?> saveImage(Uint8List? image) async {
    [Permission.storage].request;

    const name = 'screenshot';
    final result = await ImageGallerySaver.saveImage(image!, name: name);
    print(result['filePath']);
    return result['filePath'];
  }
}
