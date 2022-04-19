import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mowito_camera_application/utilities/utility_functions.dart';

import '../design_constants.dart';

class PaintPolygon extends CustomPainter {
  final List<Point> points;

  PaintPolygon(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Point recCoordinates = generateRandomPoint((size.width - recWidth).toInt(), (size.height - recHeight).toInt());

    List recVertices = [
      [recCoordinates.x, recCoordinates.y],
      [recCoordinates.x + recWidth, recCoordinates.y],
      [recCoordinates.x + recWidth, recCoordinates.y + recHeight],
      [recCoordinates.x, recCoordinates.y + recHeight]];

    Paint paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    if(isInsidePolygon(points[0], recVertices) &&
        isInsidePolygon(points[1], recVertices) &&
        isInsidePolygon(points[2], recVertices)) {
      paint.color = Colors.yellow;
    }
    else {
      paint.color = Colors.red;
    }
    
    canvas.drawRect(Offset(recCoordinates.x.toDouble(), recCoordinates.y.toDouble()) & const Size(recWidth, recHeight), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}