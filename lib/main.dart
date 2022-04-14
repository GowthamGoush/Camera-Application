import 'package:flutter/material.dart';
import 'package:mowito_camera_application/screens/camera_preview_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: CameraPreviewPage(),
  ));
}
