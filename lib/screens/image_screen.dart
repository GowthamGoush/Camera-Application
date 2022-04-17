import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mowito_camera_application/components/paint_generated_points.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;
  final List<Point> generatedPointsList;

  const ImageScreen({Key? key, required this.imagePath, required this.generatedPointsList}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: FractionalOffset.center, children: [
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
          child: RepaintBoundary(
            child: CustomPaint(
              painter: GeneratedPoints(widget.generatedPointsList),
            ),
          ),
        ),
      ]),
    );
  }
}
