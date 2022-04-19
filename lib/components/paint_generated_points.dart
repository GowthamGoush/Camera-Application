import 'package:flutter/material.dart';
import 'dart:math';

import '../design_constants.dart';

class GeneratedPoints extends CustomPainter {
  final List<Point> generatedPointsList;

  GeneratedPoints(this.generatedPointsList);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blueAccent;
    paint.strokeWidth = 5.0;

    final point1 = generatedPointsList[0];
    final point2 = generatedPointsList[1];
    //final point3 = generatedPointsList[2];

    canvas.drawCircle(Offset(point1.x.toDouble(), point1.y.toDouble()), circleRadius, paint);
    canvas.drawCircle(Offset(point2.x.toDouble(), point2.y.toDouble()), circleRadius, paint);
    //canvas.drawCircle(Offset(point3.x.toDouble(), point3.y.toDouble()), circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}