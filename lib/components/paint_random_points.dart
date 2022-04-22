import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mowito_camera_application/utilities/utility_functions.dart';

import '../design_constants.dart';

class RandomPoints extends CustomPainter {
  final ValueChanged<List<Point>> _onChange;

  RandomPoints(this._onChange);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.strokeWidth = 5.0;

    //Max length for which a circle can be drawn
    int maxWidth = size.width.toInt() - 5;
    int maxHeight = size.height.toInt() - 5;

    List<Point> _randomPointsList = generateMultipleRandomPoints(maxWidth, maxHeight);

    _onChange(_randomPointsList);

    for(Point pt in _randomPointsList) {
      canvas.drawCircle(Offset(pt.x.toDouble(), pt.y.toDouble()), circleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}