import 'dart:ui';
import 'package:flutter/material.dart';

class PaintPolygon extends CustomPainter {
  final List<Offset> vertices;

  PaintPolygon(this.vertices);

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..color = Colors.red;

    canvas.drawPoints(PointMode.polygon, vertices + [Offset(vertices.first.dx,vertices.first.dy)], paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}