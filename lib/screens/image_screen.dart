import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mowito_camera_application/components/paint_generated_points.dart';
import 'package:mowito_camera_application/design_constants.dart';
import '../components/paint_polygon.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
  List<bool> isSelected = [false, false];
  bool _isPolygonActive = false;

  bool drawPolygon = false;
  bool drawPoints = false;
  List<Offset> _vertices = [];
  List<Point> _points = [];
  List _polygonVertices = [];

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
                  painter: GeneratedPoints(widget.generatedPointsList, _polygonVertices),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: drawPoints,
              child: GestureDetector(
                onPanStart: (details) {
                  _vertices.add(details.localPosition);
                  setState(() {
                    _points.add(Point(details.localPosition.dx, details.localPosition.dy));
                  });
                },
                child: CustomPaint(
                  painter: drawPolygon ? PaintPolygon(_vertices) : GeneratedPoints(_points, _polygonVertices, paintColor: Colors.red),
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
                    final image = await screenshotController.capture();
                    if (image == null) break;
                    final path = saveImage(image);
                    break;
                }
              },
              children: const [
                Icon(
                  Icons.highlight_remove_rounded,
                ),
                Icon(Icons.save),
              ],
            ),
          )
        ]),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black26,
        elevation: 0.0,
        orientation: SpeedDialOrientation.Up,
        visible: true,
        curve: Curves.easeInBack,
        children: [
          // FAB 1
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.red.withOpacity(0.60),
            onTap: () {
              setState(() {
                drawPoints = true;
                _vertices = [];
                _points = [];
                _polygonVertices = [];
                drawPolygon = false;
              });
            },
            label: 'Draw',
            labelStyle: simpleTextStyle,
          ),

          // FAB 2
          SpeedDialChild(
            child: Icon(Icons.restore),
            backgroundColor: Colors.amber.withOpacity(0.60),
            onTap: () {
              setState(() {
                _vertices = [];
                _points = [];
                _polygonVertices = [];
                drawPolygon = false;
              });
            },
            label: 'Clear Screen',
            labelStyle: simpleTextStyle,
          ),

          // FAB 3
          SpeedDialChild(
            child: Icon(Icons.done),
            backgroundColor: Colors.green.withOpacity(0.60),
            onTap: () async {
              
              for(var point in _points){
                _polygonVertices.add([point.x, point.y]);
              }

              print(_points);
              print(_polygonVertices);
              
              setState(() {
                drawPolygon = true;
              });
            },
            label: 'Submit',
            labelStyle: simpleTextStyle,
          ),
        ],
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
