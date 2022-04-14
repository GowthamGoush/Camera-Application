import 'package:flutter/material.dart';
import 'package:mowito_camera_application/screens/camera_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: CameraPage(),
  ));
}
