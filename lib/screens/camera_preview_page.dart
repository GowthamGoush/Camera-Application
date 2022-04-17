import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewPage extends StatefulWidget {
  const CameraPreviewPage({Key? key}) : super(key: key);

  @override
  CameraAppState createState() => CameraAppState();
}

class CameraAppState extends State<CameraPreviewPage> {
  late CameraController _controller;
  bool _isInitialised = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      _controller = CameraController(cameras[0], ResolutionPreset.max);
      _controller.initialize().then((value) => setState(() {
        _isInitialised = true;
      }));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Expanded(
        child: _isInitialised
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: CameraPreview(_controller),
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<String> saveImage() async{
    var path = '';

    await _controller.takePicture().then((res) => {
      path = res.path
    });

    return path;
  }
}
