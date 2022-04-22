import 'package:flutter/material.dart';
import 'dart:math';

import '../design_constants.dart';
import '../utilities/utility_functions.dart';

class GeneratedPoints extends CustomPainter {
  final List<Point> generatedPointsList;
  final List polygonVertices;
  Color paintColor;

  GeneratedPoints(
    this.generatedPointsList,
    this.polygonVertices, {
    this.paintColor = Colors.blueAccent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = paintColor;
    paint.strokeWidth = 5.0;

    for (Point pt in generatedPointsList) {
      if (polygonVertices.isNotEmpty && isInsidePolygon(pt, polygonVertices)) {
          paint.color = Colors.yellow;
      } else {
        paint.color = paintColor;
      }

      canvas.drawCircle(
          Offset(pt.x.toDouble(), pt.y.toDouble()), circleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
