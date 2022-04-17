import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:mowito_camera_application/utilities/utility_functions.dart';

class RandomPoints extends CustomPainter {
  final ValueChanged<List<Point>> _onChange;

  RandomPoints(this._onChange);

  late Size _lastSize;

  // Generate a PNG image from canvas
  Future getPng() async {
    var recorder = ui.PictureRecorder();
    var origin = const Offset(0.0, 0.0);
    var paintBounds = Rect.fromPoints(_lastSize.topLeft(origin), _lastSize.bottomRight(origin));
    var canvas = Canvas(recorder, paintBounds);

    paint(canvas, _lastSize);

    var picture = recorder.endRecording();
    var image = await picture.toImage(_lastSize.width.round(), _lastSize.height.round());
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Saving the screenshot to the temporary directory (cache)
      Directory dir = await getTemporaryDirectory();
      File temp = File(dir.path + DateTime.now().millisecond.toString() +".png");
      temp.writeAsBytes(pngBytes);

      print("screenshot " + temp.path);
      return temp.path;
    }

    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _lastSize = size;

    Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.strokeWidth = 5.0;

    //Max length for which a circle can be drawn
    int maxWidth = size.width.toInt() - 5;
    int maxHeight = size.height.toInt() - 5;

    List<Point> _randomPointsList = generateMultipleRandomPoints(maxWidth, maxHeight);

    _onChange(_randomPointsList);

    final point1 = _randomPointsList[0];
    final point2 = _randomPointsList[1];
    final point3 = _randomPointsList[2];

    canvas.drawCircle(Offset(point1.x.toDouble(), point1.y.toDouble()), 5, paint);
    canvas.drawCircle(Offset(point2.x.toDouble(), point2.y.toDouble()), 5, paint);
    canvas.drawCircle(Offset(point3.x.toDouble(), point3.y.toDouble()), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}