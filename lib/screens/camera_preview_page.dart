import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewPage extends StatefulWidget {
  const CameraPreviewPage({Key? key}) : super(key: key);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraPreviewPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  late Future _initializeCamera;

  Future getCameras() async {
    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize();
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera = getCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
          future: _initializeCamera,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              // Show loading indicator if data is being fetched

              return Container();
            } else if (snapshot.hasError) {
              // If data is not fetched, then show an error message

              return Container();
            } else {
              return Container(
                height: height,
                child: CameraPreview(controller),
              );
            }
          }),
    );
  }
}
