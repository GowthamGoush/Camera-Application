import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mowito_camera_application/components/paint_generated_points.dart';
import '../components/paint_polygon.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  final List<Point> generatedPointsList;

  const ImageScreen(
      {Key? key, required this.imagePath, required this.generatedPointsList})
      : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<bool> isSelected = [false, false, false];
  bool _isPolygonActive = false;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Stack(alignment: FractionalOffset.center, children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Expanded(
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: !isSelected[0],
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: GeneratedPoints(widget.generatedPointsList),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: _isPolygonActive,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: PaintPolygon(widget.generatedPointsList),
                ),
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
              constraints: BoxConstraints.tightForFinite(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.06),
              isSelected: isSelected,
              onPressed: (index) async {
                switch (index) {
                  case 0:
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                    break;
                  case 1:
                    if (!_isPolygonActive) _isPolygonActive = true;
                    setState(() {});
                    break;
                  case 2:
                    final image = await screenshotController.capture();
                    if (image == null) break;
                    final path = saveImage(image);
                    break;
                }
              },
              children: [
                const Icon(
                  Icons.highlight_remove_rounded,
                ),
                _isPolygonActive
                    ? const Icon(Icons.shuffle)
                    : const Icon(Icons.format_shapes),
                const Icon(Icons.save),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Future<String?> saveImage(Uint8List? image) async {
    [Permission.storage].request;

    const name = 'mowito_images';
    final result = await ImageGallerySaver.saveImage(image!, name: name);

    const snackBar = SnackBar(
      content: Text('Saved to gallery'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    return result['filePath'];
  }
}
