import 'package:flutter/material.dart';
import 'dart:math';

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
    final point3 = generatedPointsList[2];

    canvas.drawCircle(Offset(point1.x.toDouble(), point1.y.toDouble()), 5, paint);
    canvas.drawCircle(Offset(point2.x.toDouble(), point2.y.toDouble()), 5, paint);
    canvas.drawCircle(Offset(point3.x.toDouble(), point3.y.toDouble()), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}